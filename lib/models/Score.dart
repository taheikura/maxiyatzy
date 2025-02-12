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


/** This is an auto generated class representing the Score type in your schema. */
class Score extends amplify_core.Model {
  static const classType = const _ScoreModelType();
  final String id;
  final String? _typeId;
  final ScoreType? _type;
  final int? _value;
  final User? _user;
  final ScoreSheet? _scoreSheet;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ScoreModelIdentifier get modelIdentifier {
      return ScoreModelIdentifier(
        id: id
      );
  }
  
  String get typeId {
    try {
      return _typeId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ScoreType? get type {
    return _type;
  }
  
  int? get value {
    return _value;
  }
  
  User? get user {
    return _user;
  }
  
  ScoreSheet? get scoreSheet {
    return _scoreSheet;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Score._internal({required this.id, required typeId, type, value, user, scoreSheet, createdAt, updatedAt}): _typeId = typeId, _type = type, _value = value, _user = user, _scoreSheet = scoreSheet, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Score({String? id, required String typeId, ScoreType? type, int? value, User? user, ScoreSheet? scoreSheet}) {
    return Score._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      typeId: typeId,
      type: type,
      value: value,
      user: user,
      scoreSheet: scoreSheet);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Score &&
      id == other.id &&
      _typeId == other._typeId &&
      _type == other._type &&
      _value == other._value &&
      _user == other._user &&
      _scoreSheet == other._scoreSheet;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Score {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("typeId=" + "$_typeId" + ", ");
    buffer.write("type=" + (_type != null ? _type!.toString() : "null") + ", ");
    buffer.write("value=" + (_value != null ? _value!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("scoreSheet=" + (_scoreSheet != null ? _scoreSheet!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Score copyWith({String? typeId, ScoreType? type, int? value, User? user, ScoreSheet? scoreSheet}) {
    return Score._internal(
      id: id,
      typeId: typeId ?? this.typeId,
      type: type ?? this.type,
      value: value ?? this.value,
      user: user ?? this.user,
      scoreSheet: scoreSheet ?? this.scoreSheet);
  }
  
  Score copyWithModelFieldValues({
    ModelFieldValue<String>? typeId,
    ModelFieldValue<ScoreType?>? type,
    ModelFieldValue<int?>? value,
    ModelFieldValue<User?>? user,
    ModelFieldValue<ScoreSheet?>? scoreSheet
  }) {
    return Score._internal(
      id: id,
      typeId: typeId == null ? this.typeId : typeId.value,
      type: type == null ? this.type : type.value,
      value: value == null ? this.value : value.value,
      user: user == null ? this.user : user.value,
      scoreSheet: scoreSheet == null ? this.scoreSheet : scoreSheet.value
    );
  }
  
  Score.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _typeId = json['typeId'],
      _type = json['type'] != null
          ? json['type']['serializedData'] != null
              ? ScoreType.fromJson(new Map<String, dynamic>.from(json['type']['serializedData']))
              : ScoreType.fromJson(new Map<String, dynamic>.from(json['type']))
        : null,
      _value = (json['value'] as num?)?.toInt(),
      _user = json['user'] != null
        ? json['user']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['user']))
        : null,
      _scoreSheet = json['scoreSheet'] != null
        ? json['scoreSheet']['serializedData'] != null
          ? ScoreSheet.fromJson(new Map<String, dynamic>.from(json['scoreSheet']['serializedData']))
          : ScoreSheet.fromJson(new Map<String, dynamic>.from(json['scoreSheet']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'typeId': _typeId, 'type': _type?.toJson(), 'value': _value, 'user': _user?.toJson(), 'scoreSheet': _scoreSheet?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'typeId': _typeId,
    'type': _type,
    'value': _value,
    'user': _user,
    'scoreSheet': _scoreSheet,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ScoreModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ScoreModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TYPEID = amplify_core.QueryField(fieldName: "typeId");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final VALUE = amplify_core.QueryField(fieldName: "value");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final SCORESHEET = amplify_core.QueryField(
    fieldName: "scoreSheet",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'ScoreSheet'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Score";
    modelSchemaDefinition.pluralName = "Scores";
    
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
      key: Score.TYPEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'type',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ScoreType')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Score.VALUE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Score.USER,
      isRequired: false,
      targetNames: ['userId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Score.SCORESHEET,
      isRequired: false,
      targetNames: ['scoreSheetId'],
      ofModelName: 'ScoreSheet'
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

class _ScoreModelType extends amplify_core.ModelType<Score> {
  const _ScoreModelType();
  
  @override
  Score fromJson(Map<String, dynamic> jsonData) {
    return Score.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Score';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Score] in your schema.
 */
class ScoreModelIdentifier implements amplify_core.ModelIdentifier<Score> {
  final String id;

  /** Create an instance of ScoreModelIdentifier using [id] the primary key. */
  const ScoreModelIdentifier({
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
  String toString() => 'ScoreModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ScoreModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}