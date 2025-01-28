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


/** This is an auto generated class representing the Result type in your schema. */
class Result extends amplify_core.Model {
  static const classType = const _ResultModelType();
  final String id;
  final String? _name;
  final String? _content;
  final Game? _game;
  final List<ResultUser>? _users;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ResultModelIdentifier get modelIdentifier {
      return ResultModelIdentifier(
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
  
  String get content {
    try {
      return _content!;
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
  
  List<ResultUser>? get users {
    return _users;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Result._internal({required this.id, required name, required content, game, users, createdAt, updatedAt}): _name = name, _content = content, _game = game, _users = users, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Result({String? id, required String name, required String content, Game? game, List<ResultUser>? users}) {
    return Result._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      content: content,
      game: game,
      users: users != null ? List<ResultUser>.unmodifiable(users) : users);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Result &&
      id == other.id &&
      _name == other._name &&
      _content == other._content &&
      _game == other._game &&
      DeepCollectionEquality().equals(_users, other._users);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Result {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("game=" + (_game != null ? _game!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Result copyWith({String? name, String? content, Game? game, List<ResultUser>? users}) {
    return Result._internal(
      id: id,
      name: name ?? this.name,
      content: content ?? this.content,
      game: game ?? this.game,
      users: users ?? this.users);
  }
  
  Result copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String>? content,
    ModelFieldValue<Game?>? game,
    ModelFieldValue<List<ResultUser>?>? users
  }) {
    return Result._internal(
      id: id,
      name: name == null ? this.name : name.value,
      content: content == null ? this.content : content.value,
      game: game == null ? this.game : game.value,
      users: users == null ? this.users : users.value
    );
  }
  
  Result.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _content = json['content'],
      _game = json['game'] != null
        ? json['game']['serializedData'] != null
          ? Game.fromJson(new Map<String, dynamic>.from(json['game']['serializedData']))
          : Game.fromJson(new Map<String, dynamic>.from(json['game']))
        : null,
      _users = json['users']  is Map
        ? (json['users']['items'] is List
          ? (json['users']['items'] as List)
              .where((e) => e != null)
              .map((e) => ResultUser.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['users'] is List
          ? (json['users'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => ResultUser.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'content': _content, 'game': _game?.toJson(), 'users': _users?.map((ResultUser? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'content': _content,
    'game': _game,
    'users': _users,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ResultModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ResultModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final GAME = amplify_core.QueryField(
    fieldName: "game",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Game'));
  static final USERS = amplify_core.QueryField(
    fieldName: "users",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'ResultUser'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Result";
    modelSchemaDefinition.pluralName = "Results";
    
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
      key: Result.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Result.CONTENT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Result.GAME,
      isRequired: false,
      targetNames: ['gameId'],
      ofModelName: 'Game'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Result.USERS,
      isRequired: false,
      ofModelName: 'ResultUser',
      associatedKey: ResultUser.RESULT
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

class _ResultModelType extends amplify_core.ModelType<Result> {
  const _ResultModelType();
  
  @override
  Result fromJson(Map<String, dynamic> jsonData) {
    return Result.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Result';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Result] in your schema.
 */
class ResultModelIdentifier implements amplify_core.ModelIdentifier<Result> {
  final String id;

  /** Create an instance of ResultModelIdentifier using [id] the primary key. */
  const ResultModelIdentifier({
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
  String toString() => 'ResultModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ResultModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}