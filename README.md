Maksi Jatsi
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Development notes](#development-notes)
  - [Useful VS Code extensions](#useful-vs-code-extensions)
  - [Prerequisites](#prerequisites)
  - [Create frontend](#create-frontend)
  - [Create backend](#create-backend)
  - [Use Volta to pin tools and yarn to install and test](#use-volta-to-pin-tools-and-yarn-to-install-and-test)
  - [Use per-developer cloud sandbox](#use-per-developer-cloud-sandbox)
  - [Update existing project](#update-existing-project)
  - [Authentication](#authentication)
  - [Deploy sandbox and run](#deploy-sandbox-and-run)
- [Data model](#data-model)
  - [Connect application code to data backend](#connect-application-code-to-data-backend)

<!-- /code_chunk_output -->

# Development notes
*Flutter* for desktop/mobile
Auth UI flow from Flutter
Requires *Android Studio* from Google
[Amplify Flutter quickstart](https://docs.amplify.aws/flutter/start/quickstart/)

## Useful VS Code extensions
[Pubspec Assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)
[Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
[Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens)
[Apache Velocity](https://marketplace.visualstudio.com/items?itemName=luqimin.velocity)
[AWS Toolkit](https://marketplace.visualstudio.com/items?itemName=amazonwebservices.aws-toolkit-vscode)

## Prerequisites
>yarn global add aws-cdk

## Create frontend
>flutter create maxiyatzy

## Create backend
>cd maxiyatzy
npm create amplify@latest -y

Backend files have been created under directory amplify.

You may optionally disable Amplify usage telemetry
>npx ampx configure telemetry disable

## Use Volta to pin tools and yarn to install and test
>volta pin node npm

Volta will now automatically link and use the correct cli tool versions that have now been pinned to package.json.

## Use per-developer cloud sandbox
Create
>npx ampx sandbox --outputs-format dart --outputs-out-dir lib

Delete
>npx ampx sandbox delete

## Update existing project
>npm update @aws-amplify/backend @aws-amplify/backend-cli

## Authentication
Update Amplify auth as needed amplify/auth/resource.ts\
Update Flutter related dependencies in pubspec.yaml to include\
amplify_flutter: ^2.0.0\
amplify_auth_cognito: ^2.0.0\
amplify_authenticator: ^2.0.0
>flutter pub get

Authentication UI is ready after lib/main.dart is updated to use Amplify UI components.

## Deploy sandbox and run
>npx ampx sandbox --outputs-format dart --outputs-out-dir lib\
flutter run

# Data model
[Official: Amplify Flutter - Set up data](https://docs.amplify.aws/flutter/build-a-backend/data/set-up-data/)

pubspec.yaml:
>amplify_api: ^2.0.0

>flutter pub get
flutter pub outdated
-Use Version Lens extension to upgrade

Modify amplify/data/resource.ts
Re-Deploy sandbox
Once the cloud sandbox is up and running, it will create an amplify_outputs.dart file, which includes connection information to the backend,
like your API endpoint URL and API key.

## Connect application code to data backend
To connect your frontend code to your backend, you need to:

1. Configure the Amplify library with the Amplify client configuration file (amplify_outputs.json)
2. Generate a new API client from the Amplify library
>npx ampx generate graphql-client-code --format modelgen --model-target dart --out lib/models
3. Make an API request with end-to-end type-safety

