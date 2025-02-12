/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the User type in your schema. */
class User extends amplify_core.Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _profileOwner;
  final String? _name;
  final Game? _game;
  final Game? _hosting;
  final Game? _gameTurn;
  final List<Score>? _scores;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get profileOwner {
    return _profileOwner;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Game? get game {
    return _game;
  }
  
  Game? get hosting {
    return _hosting;
  }
  
  Game? get gameTurn {
    return _gameTurn;
  }
  
  List<Score>? get scores {
    return _scores;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, profileOwner, required name, game, hosting, gameTurn, scores, createdAt, updatedAt}): _profileOwner = profileOwner, _name = name, _game = game, _hosting = hosting, _gameTurn = gameTurn, _scores = scores, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? profileOwner, required String name, Game? game, Game? hosting, Game? gameTurn, List<Score>? scores}) {
    return User._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      profileOwner: profileOwner,
      name: name,
      game: game,
      hosting: hosting,
      gameTurn: gameTurn,
      scores: scores != null ? List<Score>.unmodifiable(scores) : scores);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _profileOwner == other._profileOwner &&
      _name == other._name &&
      _game == other._game &&
      _hosting == other._hosting &&
      _gameTurn == other._gameTurn &&
      DeepCollectionEquality().equals(_scores, other._scores);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("profileOwner=" + "$_profileOwner" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("game=" + (_game != null ? _game!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? profileOwner, String? name, Game? game, Game? hosting, Game? gameTurn, List<Score>? scores}) {
    return User._internal(
      id: id,
      profileOwner: profileOwner ?? this.profileOwner,
      name: name ?? this.name,
      game: game ?? this.game,
      hosting: hosting ?? this.hosting,
      gameTurn: gameTurn ?? this.gameTurn,
      scores: scores ?? this.scores);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String?>? profileOwner,
    ModelFieldValue<String>? name,
    ModelFieldValue<Game?>? game,
    ModelFieldValue<Game?>? hosting,
    ModelFieldValue<Game?>? gameTurn,
    ModelFieldValue<List<Score>?>? scores
  }) {
    return User._internal(
      id: id,
      profileOwner: profileOwner == null ? this.profileOwner : profileOwner.value,
      name: name == null ? this.name : name.value,
      game: game == null ? this.game : game.value,
      hosting: hosting == null ? this.hosting : hosting.value,
      gameTurn: gameTurn == null ? this.gameTurn : gameTurn.value,
      scores: scores == null ? this.scores : scores.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _profileOwner = json['profileOwner'],
      _name = json['name'],
      _game = json['game'] != null
        ? json['game']['serializedData'] != null
          ? Game.fromJson(new Map<String, dynamic>.from(json['game']['serializedData']))
          : Game.fromJson(new Map<String, dynamic>.from(json['game']))
        : null,
      _hosting = json['hosting'] != null
        ? json['hosting']['serializedData'] != null
          ? Game.fromJson(new Map<String, dynamic>.from(json['hosting']['serializedData']))
          : Game.fromJson(new Map<String, dynamic>.from(json['hosting']))
        : null,
      _gameTurn = json['gameTurn'] != null
        ? json['gameTurn']['serializedData'] != null
          ? Game.fromJson(new Map<String, dynamic>.from(json['gameTurn']['serializedData']))
          : Game.fromJson(new Map<String, dynamic>.from(json['gameTurn']))
        : null,
      _scores = json['scores']  is Map
        ? (json['scores']['items'] is List
          ? (json['scores']['items'] as List)
              .where((e) => e != null)
              .map((e) => Score.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['scores'] is List
          ? (json['scores'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Score.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'profileOwner': _profileOwner, 'name': _name, 'game': _game?.toJson(), 'hosting': _hosting?.toJson(), 'gameTurn': _gameTurn?.toJson(), 'scores': _scores?.map((Score? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'profileOwner': _profileOwner,
    'name': _name,
    'game': _game,
    'hosting': _hosting,
    'gameTurn': _gameTurn,
    'scores': _scores,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PROFILEOWNER = amplify_core.QueryField(fieldName: "profileOwner");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final GAME = amplify_core.QueryField(
    fieldName: "game",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Game'));
  static final HOSTING = amplify_core.QueryField(
    fieldName: "hosting",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Game'));
  static final GAMETURN = amplify_core.QueryField(
    fieldName: "gameTurn",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Game'));
  static final SCORES = amplify_core.QueryField(
    fieldName: "scores",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Score'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "profileOwner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["profileOwner"], name: "usersByProfileOwner")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.PROFILEOWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: User.GAME,
      isRequired: false,
      targetNames: ['gameId'],
      ofModelName: 'Game'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: User.HOSTING,
      isRequired: false,
      ofModelName: 'Game',
      associatedKey: Game.CREATEDBY
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: User.GAMETURN,
      isRequired: false,
      ofModelName: 'Game',
      associatedKey: Game.WHOSTURN
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.SCORES,
      isRequired: false,
      ofModelName: 'Score',
      associatedKey: Score.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends amplify_core.ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
class UserModelIdentifier implements amplify_core.ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}