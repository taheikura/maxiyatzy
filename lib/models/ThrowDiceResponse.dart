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


/** This is an auto generated class representing the ThrowDiceResponse type in your schema. */
class ThrowDiceResponse {
  final Vector3? _gravity;
  final Vector3? _groundPosition;
  final List<Die>? _dice;

  Vector3? get gravity {
    return _gravity;
  }
  
  Vector3? get groundPosition {
    return _groundPosition;
  }
  
  List<Die>? get dice {
    return _dice;
  }
  
  const ThrowDiceResponse._internal({gravity, groundPosition, dice}): _gravity = gravity, _groundPosition = groundPosition, _dice = dice;
  
  factory ThrowDiceResponse({Vector3? gravity, Vector3? groundPosition, List<Die>? dice}) {
    return ThrowDiceResponse._internal(
      gravity: gravity,
      groundPosition: groundPosition,
      dice: dice != null ? List<Die>.unmodifiable(dice) : dice);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThrowDiceResponse &&
      _gravity == other._gravity &&
      _groundPosition == other._groundPosition &&
      DeepCollectionEquality().equals(_dice, other._dice);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ThrowDiceResponse {");
    buffer.write("gravity=" + (_gravity != null ? _gravity!.toString() : "null") + ", ");
    buffer.write("groundPosition=" + (_groundPosition != null ? _groundPosition!.toString() : "null") + ", ");
    buffer.write("dice=" + (_dice != null ? _dice!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ThrowDiceResponse copyWith({Vector3? gravity, Vector3? groundPosition, List<Die>? dice}) {
    return ThrowDiceResponse._internal(
      gravity: gravity ?? this.gravity,
      groundPosition: groundPosition ?? this.groundPosition,
      dice: dice ?? this.dice);
  }
  
  ThrowDiceResponse copyWithModelFieldValues({
    ModelFieldValue<Vector3?>? gravity,
    ModelFieldValue<Vector3?>? groundPosition,
    ModelFieldValue<List<Die>?>? dice
  }) {
    return ThrowDiceResponse._internal(
      gravity: gravity == null ? this.gravity : gravity.value,
      groundPosition: groundPosition == null ? this.groundPosition : groundPosition.value,
      dice: dice == null ? this.dice : dice.value
    );
  }
  
  ThrowDiceResponse.fromJson(Map<String, dynamic> json)  
    : _gravity = json['gravity'] != null
          ? json['gravity']['serializedData'] != null
              ? Vector3.fromJson(new Map<String, dynamic>.from(json['gravity']['serializedData']))
              : Vector3.fromJson(new Map<String, dynamic>.from(json['gravity']))
        : null,
      _groundPosition = json['groundPosition'] != null
          ? json['groundPosition']['serializedData'] != null
              ? Vector3.fromJson(new Map<String, dynamic>.from(json['groundPosition']['serializedData']))
              : Vector3.fromJson(new Map<String, dynamic>.from(json['groundPosition']))
        : null,
      _dice = json['dice'] is List
        ? (json['dice'] as List)
          .where((e) => e != null)
          .map((e) => Die.fromJson(new Map<String, dynamic>.from(e['serializedData'] ?? e)))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'gravity': _gravity?.toJson(), 'groundPosition': _groundPosition?.toJson(), 'dice': _dice?.map((Die? e) => e?.toJson()).toList()
  };
  
  Map<String, Object?> toMap() => {
    'gravity': _gravity,
    'groundPosition': _groundPosition,
    'dice': _dice
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ThrowDiceResponse";
    modelSchemaDefinition.pluralName = "ThrowDiceResponses";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'gravity',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Vector3')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'groundPosition',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Vector3')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'dice',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Die')
    ));
  });
}