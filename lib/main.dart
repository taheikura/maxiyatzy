import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maxiyatzy/home_page.dart';

import 'amplify_outputs.dart';
import 'models/ModelProvider.dart';

final AmplifyLogger _logger = AmplifyLogger('MaxiYatzyApp');

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureAmplify();
    runApp(const MaxiYatzyApp());
  } on AmplifyException catch (e) {
    runApp(Text("Error configuring Amplify: ${e.message}"));
  }
}

Future<void> _configureAmplify() async {
  try {
    AmplifyLogger().logLevel = LogLevel.debug;

    final api = AmplifyAPI(
        options: APIPluginOptions(
            modelProvider: ModelProvider.instance,
            subscriptionOptions: const GraphQLSubscriptionOptions(
              retryOptions: RetryOptions(),
            )));
    await Amplify.addPlugins([AmplifyAuthCognito(), api]);
    await Amplify.configure(amplifyConfig);
    _logger.debug('Successfully configured Amplify');
  } on AmplifyAlreadyConfiguredException {
    _logger.debug(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  } on Exception catch (e) {
    _logger.error('Error configuring Amplify: $e');
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

Future<String> fetchUserAttributes(String key) async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    for (final element in result) {
      if (element.userAttributeKey.key == key) {
        return element.value;
      }
    }
  } on AuthException catch (e) {
    _logger.warn('Error fetching user attributes', e);
  }
  return "";
}

Future<void> deleteGameUser(String id) async {
  final request =
      ModelMutations.deleteById(User.classType, UserModelIdentifier(id: id));
  final response = await Amplify.API.mutate(request: request).response;
  if (response.hasErrors) {
    safePrint('Deleting game user failed: ${response.errors}');
  } else {
    safePrint('Delete game user succeeded');
  }
}

class MaxiYatzyApp extends StatelessWidget {
  const MaxiYatzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: HomePage(),
      ),
    );
  }
}
