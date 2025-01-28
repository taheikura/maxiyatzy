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


/** This is an auto generated class representing the Game type in your schema. */
class Game extends amplify_core.Model {
  static const classType = const _GameModelType();
  final String id;
  final String? _name;
  final GameState? _state;
  final List<Result>? _results;
  final List<User>? _users;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  GameModelIdentifier get modelIdentifier {
      return GameModelIdentifier(
        id: id
      );
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
  
  GameState? get state {
    return _state;
  }
  
  List<Result>? get results {
    return _results;
  }
  
  List<User>? get users {
    return _users;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Game._internal({required this.id, required name, state, results, users, createdAt, updatedAt}): _name = name, _state = state, _results = results, _users = users, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Game({String? id, required String name, GameState? state, List<Result>? results, List<User>? users}) {
    return Game._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      state: state,
      results: results != null ? List<Result>.unmodifiable(results) : results,
      users: users != null ? List<User>.unmodifiable(users) : users);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Game &&
      id == other.id &&
      _name == other._name &&
      _state == other._state &&
      DeepCollectionEquality().equals(_results, other._results) &&
      DeepCollectionEquality().equals(_users, other._users);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Game {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("state=" + (_state != null ? amplify_core.enumToString(_state)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Game copyWith({String? name, GameState? state, List<Result>? results, List<User>? users}) {
    return Game._internal(
      id: id,
      name: name ?? this.name,
      state: state ?? this.state,
      results: results ?? this.results,
      users: users ?? this.users);
  }
  
  Game copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<GameState?>? state,
    ModelFieldValue<List<Result>?>? results,
    ModelFieldValue<List<User>?>? users
  }) {
    return Game._internal(
      id: id,
      name: name == null ? this.name : name.value,
      state: state == null ? this.state : state.value,
      results: results == null ? this.results : results.value,
      users: users == null ? this.users : users.value
    );
  }
  
  Game.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _state = amplify_core.enumFromString<GameState>(json['state'], GameState.values),
      _results = json['results']  is Map
        ? (json['results']['items'] is List
          ? (json['results']['items'] as List)
              .where((e) => e != null)
              .map((e) => Result.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['results'] is List
          ? (json['results'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Result.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _users = json['users']  is Map
        ? (json['users']['items'] is List
          ? (json['users']['items'] as List)
              .where((e) => e != null)
              .map((e) => User.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['users'] is List
          ? (json['users'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => User.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'state': amplify_core.enumToString(_state), 'results': _results?.map((Result? e) => e?.toJson()).toList(), 'users': _users?.map((User? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'state': _state,
    'results': _results,
    'users': _users,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<GameModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<GameModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final RESULTS = amplify_core.QueryField(
    fieldName: "results",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Result'));
  static final USERS = amplify_core.QueryField(
    fieldName: "users",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Game";
    modelSchemaDefinition.pluralName = "Games";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Game.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Game.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Game.RESULTS,
      isRequired: false,
      ofModelName: 'Result',
      associatedKey: Result.GAME
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Game.USERS,
      isRequired: false,
      ofModelName: 'User',
      associatedKey: User.GAME
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

class _GameModelType extends amplify_core.ModelType<Game> {
  const _GameModelType();
  
  @override
  Game fromJson(Map<String, dynamic> jsonData) {
    return Game.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Game';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Game] in your schema.
 */
class GameModelIdentifier implements amplify_core.ModelIdentifier<Game> {
  final String id;

  /** Create an instance of GameModelIdentifier using [id] the primary key. */
  const GameModelIdentifier({
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
  String toString() => 'GameModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is GameModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}