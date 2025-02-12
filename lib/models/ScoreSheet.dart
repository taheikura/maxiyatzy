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


/** This is an auto generated class representing the ScoreSheet type in your schema. */
class ScoreSheet extends amplify_core.Model {
  static const classType = const _ScoreSheetModelType();
  final String id;
  final Game? _game;
  final List<Score>? _score;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ScoreSheetModelIdentifier get modelIdentifier {
      return ScoreSheetModelIdentifier(
        id: id
      );
  }
  
  Game? get game {
    return _game;
  }
  
  List<Score>? get score {
    return _score;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ScoreSheet._internal({required this.id, game, score, createdAt, updatedAt}): _game = game, _score = score, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ScoreSheet({String? id, Game? game, List<Score>? score}) {
    return ScoreSheet._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      game: game,
      score: score != null ? List<Score>.unmodifiable(score) : score);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreSheet &&
      id == other.id &&
      _game == other._game &&
      DeepCollectionEquality().equals(_score, other._score);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ScoreSheet {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("game=" + (_game != null ? _game!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ScoreSheet copyWith({Game? game, List<Score>? score}) {
    return ScoreSheet._internal(
      id: id,
      game: game ?? this.game,
      score: score ?? this.score);
  }
  
  ScoreSheet copyWithModelFieldValues({
    ModelFieldValue<Game?>? game,
    ModelFieldValue<List<Score>?>? score
  }) {
    return ScoreSheet._internal(
      id: id,
      game: game == null ? this.game : game.value,
      score: score == null ? this.score : score.value
    );
  }
  
  ScoreSheet.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _game = json['game'] != null
        ? json['game']['serializedData'] != null
          ? Game.fromJson(new Map<String, dynamic>.from(json['game']['serializedData']))
          : Game.fromJson(new Map<String, dynamic>.from(json['game']))
        : null,
      _score = json['score']  is Map
        ? (json['score']['items'] is List
          ? (json['score']['items'] as List)
              .where((e) => e != null)
              .map((e) => Score.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['score'] is List
          ? (json['score'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Score.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'game': _game?.toJson(), 'score': _score?.map((Score? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'game': _game,
    'score': _score,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ScoreSheetModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ScoreSheetModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final GAME = amplify_core.QueryField(
    fieldName: "game",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Game'));
  static final SCORE = amplify_core.QueryField(
    fieldName: "score",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Score'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ScoreSheet";
    modelSchemaDefinition.pluralName = "ScoreSheets";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: ScoreSheet.GAME,
      isRequired: false,
      targetNames: ['gameId'],
      ofModelName: 'Game'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: ScoreSheet.SCORE,
      isRequired: false,
      ofModelName: 'Score',
      associatedKey: Score.SCORESHEET
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

class _ScoreSheetModelType extends amplify_core.ModelType<ScoreSheet> {
  const _ScoreSheetModelType();
  
  @override
  ScoreSheet fromJson(Map<String, dynamic> jsonData) {
    return ScoreSheet.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'ScoreSheet';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ScoreSheet] in your schema.
 */
class ScoreSheetModelIdentifier implements amplify_core.ModelIdentifier<ScoreSheet> {
  final String id;

  /** Create an instance of ScoreSheetModelIdentifier using [id] the primary key. */
  const ScoreSheetModelIdentifier({
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
  String toString() => 'ScoreSheetModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ScoreSheetModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}