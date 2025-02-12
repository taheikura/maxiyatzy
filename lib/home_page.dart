import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:maxiyatzy/game_screen.dart';
import 'package:maxiyatzy/main.dart';
import 'package:maxiyatzy/models/ModelProvider.dart';

final AmplifyLogger _logger = AmplifyLogger('MaxiYatzyApp');

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  SubscriptionStatus prevSubscriptionStatus = SubscriptionStatus.disconnected;
  StreamSubscription<GraphQLResponse<Game>>? onCreateSubscription;
  StreamSubscription<GraphQLResponse<Game>>? onDeleteSubscription;

  List<Game> _games = [];
  late Timer timer;

  bool _isLoading = true;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initListeners();
    subscribe();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => _refreshGames());
  }

  @override
  void dispose() {
    unsubscribe();
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  void _initListeners() {
    // Init listeners
    Amplify.Hub.listen(
      HubChannel.Api,
      (ApiHubEvent event) {
        if (event is SubscriptionHubEvent) {
          if (prevSubscriptionStatus == SubscriptionStatus.connecting &&
              event.status == SubscriptionStatus.connected) {
            _refreshGames();
          }
          prevSubscriptionStatus = event.status;
        }
      },
    );
  }

  void sortGames() {
    _games.sort((a, b) => a.createdAt != null && b.createdAt != null
        ? b.createdAt!.compareTo(a.createdAt!)
        : 0);
  }

  void subscribe() {
    final onCreateRequest = ModelSubscriptions.onCreate(Game.classType);
    final onDeleteRequest = ModelSubscriptions.onDelete(Game.classType);

    final Stream<GraphQLResponse<Game>> create = Amplify.API.subscribe(
      onCreateRequest,
    );
    final Stream<GraphQLResponse<Game>> delete = Amplify.API.subscribe(
      onDeleteRequest,
    );

    onCreateSubscription = create.listen(
      (event) {
        if (event.data != null) {
          setState(() {
            _games.add(event.data!);
            sortGames();
          });
        }
      },
      onError: (Object e) => _logger.error('Error in subscription stream', e),
    );
    onDeleteSubscription = delete.listen(
      (event) {
        if (event.data != null) {
          setState(() {
            _games.remove(event.data);
            sortGames();
          });
        }
      },
      onError: (Object e) => _logger.error('Error in subscription stream', e),
    );
  }

  void unsubscribe() {
    onCreateSubscription?.cancel();
    onDeleteSubscription?.cancel();
    onCreateSubscription = null;
    onDeleteSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    Jiffy dateNow = Jiffy.parseFromDateTime(DateTime.now().toUtc());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maksi Jatsi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SignOutButton(),
              ElevatedButton(
                onPressed: _refreshGames,
                child: Text('Refresh'),
              ),
              _games.isEmpty == true && _isLoading == false
                  ? const Center(
                      child: Text(
                        "No games.\nCreate one by clicking the plus icon.",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _games.isEmpty
                      ? const Center(child: Text(""))
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _games.length,
                          itemBuilder: (context, index) {
                            final game = _games[index];
                            TemporalDateTime dt = game.createdAt ??
                                TemporalDateTime(DateTime.now().toUtc());
                            Jiffy date =
                                Jiffy.parseFromDateTime(dt.getDateTimeInUtc());
                            String players = 'No players';
                            if (game.users != null && game.users!.isNotEmpty) {
                              players = game.users!.length > 1
                                  ? '${game.users!.length} players'
                                  : '1 player';
                            }
                            return ListTile(
                              title: Text(game.name),
                              subtitle: Text(date.from(dateNow)),
                              trailing: Text(players),
                              onTap: () async {
                                final authUser =
                                    await Amplify.Auth.getCurrentUser();
                                User? user = await getUser(authUser.userId);
                                if (user != null) {
                                  joinGame(game, user);
                                } else {
                                  _logger.warn('User profile not found');
                                }
                              },
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
                createNewGame(controller.text);
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('SUBMIT'),
            ),
          ]),
    );
  }

  Future<void> _refreshGames() async {
    setState(() {
      _isLoading = true;
    });

    List<Game> games = _games;
    try {
      final request = ModelQueries.list(Game.classType,
          where: Game.STATE.eq(GameState.joinable));
      final response = await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        _logger.error('Refresh games errors', response.errors);
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final items = response.data?.items;
      if (items != null) {
        games = items.whereType<Game>().toList();
      } else {
        games = [];
      }
    } on ApiException catch (e) {
      _logger.error('Query failed', e);
    }

    setState(() {
      _games = games;
      sortGames();
      _isLoading = false;
    });
  }

  Future<Game?> createNewGame(String name) async {
    setState(() {
      _isLoading = true;
    });

    Game? game;
    try {
      final newGame = Game(name: name, state: GameState.joinable);
      final request = ModelMutations.create(newGame);
      final response = await Amplify.API.mutate(request: request).response;

      final createdGame = response.data;
      if (createdGame == null) {
        _logger.error('Creating game failed: ${response.errors}');
      }
      _logger.info('Creating game succeeded: ${createdGame!.name}');

      game = createdGame;
    } on ApiException catch (e) {
      _logger.error('Mutation failed', e);
    }

    setState(() {
      _isLoading = false;
    });

    return game;
  }

  void joinGame(Game game, User user) {
    // Navigate to the game screen
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GameScreen(game: game, user: user),
    ));
  }

  Future<User?> getUser(String userId) async {
    try {
      _logger.info('Getting user info for $userId');
      final request = ModelQueries.list(User.classType,
          where: User.PROFILEOWNER.contains(userId));
      final response = await Amplify.API.query(request: request).response;
      if (!response.hasErrors) {
        if (response.data?.items.isEmpty == true) {
          _logger.error('User profile not created');
          throw ApiOperationException('User profile not created');
        }
        _logger.debug(response.toString());
        return response.data?.items.first;
      }

      throw ApiOperationException('${response.errors}');
    } on AmplifyException catch (e) {
      _logger.error('User profile query', e);
      return null;
    }
  }
}
