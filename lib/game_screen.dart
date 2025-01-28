import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maxiyatzy/main.dart';
import 'package:maxiyatzy/models/ModelProvider.dart';

class GameScreen extends StatefulWidget {
  final Game game;

  @override
  State<GameScreen> createState() => _GameScreenState();

  const GameScreen({super.key, required this.game});
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _joinGame(widget.game);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _leaveGame(widget.game);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Game: ${widget.game.name}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Back to lobby"),
            )
          ]
        ),
        body: Center(
          child: Text("Welcome to the game: ${widget.game.name}"),
        ),
      ),
    );
  }

  Future<void> _joinGame(Game game) async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final originalUser = await getUser(user.userId);
      if (originalUser == null) {
        safePrint('Original user not found');
        return;
      }

      final updatedUser = originalUser.copyWith(game: game);
      final request = ModelMutations.update(updatedUser);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('JoinGame failed: $e');
    }
  }

  Future<void> _leaveGame(Game game) async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final originalUser = await getUser(user.userId);
      if (originalUser == null) {
        safePrint('Original user not found');
        return;
      }

      final updatedUser = originalUser.copyWith(game: null);
      final request = ModelMutations.update(updatedUser);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } on ApiException catch (e) {
      safePrint('LeaveGame failed: $e');
    }
  }
}
