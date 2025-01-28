import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';import 'package:flutter/material.dart';
import 'package:maxiyatzy/game_screen.dart';

import 'amplify_outputs.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureAmplify();
    runApp(const MyApp());
  } on AmplifyException catch (e) {
    runApp(Text("Error configuring Amplify: ${e.message}"));
  }
}

Future<void> _configureAmplify() async {
  try {
    final api = AmplifyAPI(
      options: APIPluginOptions(
        modelProvider: ModelProvider.instance
      )
    );
    await Amplify.addPlugins([AmplifyAuthCognito(), api]);
    await Amplify.configure(amplifyConfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}


Future<void> deleteUser() async {
  try {
    final user = await Amplify.Auth.getCurrentUser();
    await Amplify.Auth.deleteUser();
    await deleteGameUser(user.userId);
    safePrint('Delete user succeeded');
  } on AuthException catch (e) {
    safePrint('Delete user failed with error: $e');
  }
}

Future<User?> getUser(String id) async {
  try {
    final request = ModelQueries.get(User.classType, UserModelIdentifier(id: id));
    final response = await Amplify.API.query(request: request).response;
    if (response.hasErrors) {
      safePrint('Fetching game user failed: ${response.hasErrors}');
      return null;
    }
    final user = response.data;
    if (user != null) {
      safePrint('Fetching game user succeeded');
      return user;
    }

    await createGameUser();
    final newUserResponse = await Amplify.API.query(request: request).response;
    final newUser = newUserResponse.data;
    if (newUser != null) {
      return newUser;
    } else {
      safePrint('Creating first time user failed ${newUserResponse.errors}');
    }
  } on ApiException catch (e) {
    safePrint('Query failed: $e');
  }

  return null;
}

// Make sure user row exists in dynamodb before continuing.
// - may need to redesign where to save session info.
Future<void> createGameUser() async {
  try {
    final user = await Amplify.Auth.getCurrentUser();
    final gameUser = await getUser(user.userId);
    final GraphQLRequest<User> request;
    if (gameUser == null) {
      request = ModelMutations.create(User(id: user.userId, game: null));
    } else {
      final lobbyUser = gameUser.copyWith(game: null);
      request = ModelMutations.update(lobbyUser);
    }

    final response = await Amplify.API.mutate(request: request).response;
    if (response.data == null) {
      safePrint('Create user failed: ${response.errors}');
    }
  }  on ApiException catch (e) {
    safePrint('Create user failed: $e');
  }
}

Future<void> deleteGameUser(String id) async {
  final request = ModelMutations.deleteById(User.classType, UserModelIdentifier(id: id));
  final response = await Amplify.API.mutate(request: request).response;
  if (response.hasErrors) {
    safePrint('Deleting game user failed: ${response.errors}');
  } else {
    safePrint('Delete game user succeeded');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Game> _games = [];
  bool _isLoading = false;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    createGameUser();
    _refreshGames();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _refreshGames() async {
    try {
      final request = ModelQueries.list(Game.classType, where: Game.STATE.eq(GameState.joinable));
      final response = await Amplify.API.query(request: request).response;

      final games = response.data?.items;
      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }
      setState(() {
        safePrint(games);
        _games = games!.whereType<Game>().toList();
      });
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maksi Jatsi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignOutButton(),
              _games.isEmpty == true
                ? const Center(
                    child: Text(
                      "No games.\nCreate one by clicking the plus icon.",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _games.length,
                    itemBuilder: (context, index) {
                      final game = _games[index];
                      
                      return ListTile(
                        title: Text(game.name),
                        onTap: () { joinGame(game); },
                      );
                    }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createGame,
          tooltip: 'Create room',
          child: _isLoading ? CircularProgressIndicator() : Icon(Icons.add)),
      ),
    );
  }

  Future _createGame() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: const Text('Create game'),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter game name'),
          maxLength: 32,
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'required';
            }
            return null;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _createNewGame(controller.text);
              Navigator.of(context).pop(controller.text);
            },
            child: const Text('SUBMIT'),
          ),
        ]
      ),
    );
  }

  void joinGame(Game game) {
    // Navigate to the game screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameScreen(game: game),
      )
    );
  }

  Future<Game?> _createNewGame(String name) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final newGame = Game(name: name, state: GameState.joinable);
      final request = ModelMutations.create(newGame);
      final response = await Amplify.API.mutate(request: request).response;

      final createdGame = response.data;
      if (createdGame == null) {
        safePrint('Creating game failed: ${response.errors}');
      }
      safePrint('Creating game succeeded: ${createdGame!.name}');

      setState(() { _isLoading = false; });

      joinGame(createdGame);

      return createdGame;
    } on ApiException catch (e) {
      setState(() { _isLoading = false; });
      safePrint('Mutation failed: $e');
    }

    return null;
  }
}
