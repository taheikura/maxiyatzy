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


/** This is an auto generated class representing the Die type in your schema. */
class Die {
  final Vector3? _position;
  final DieQuaternion? _quaternion;
  final Vector3? _velocity;
  final Vector3? _angularVelocity;

  Vector3? get position {
    return _position;
  }
  
  DieQuaternion? get quaternion {
    return _quaternion;
  }
  
  Vector3? get velocity {
    return _velocity;
  }
  
  Vector3? get angularVelocity {
    return _angularVelocity;
  }
  
  const Die._internal({position, quaternion, velocity, angularVelocity}): _position = position, _quaternion = quaternion, _velocity = velocity, _angularVelocity = angularVelocity;
  
  factory Die({Vector3? position, DieQuaternion? quaternion, Vector3? velocity, Vector3? angularVelocity}) {
    return Die._internal(
      position: position,
      quaternion: quaternion,
      velocity: velocity,
      angularVelocity: angularVelocity);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Die &&
      _position == other._position &&
      _quaternion == other._quaternion &&
      _velocity == other._velocity &&
      _angularVelocity == other._angularVelocity;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Die {");
    buffer.write("position=" + (_position != null ? _position!.toString() : "null") + ", ");
    buffer.write("quaternion=" + (_quaternion != null ? _quaternion!.toString() : "null") + ", ");
    buffer.write("velocity=" + (_velocity != null ? _velocity!.toString() : "null") + ", ");
    buffer.write("angularVelocity=" + (_angularVelocity != null ? _angularVelocity!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Die copyWith({Vector3? position, DieQuaternion? quaternion, Vector3? velocity, Vector3? angularVelocity}) {
    return Die._internal(
      position: position ?? this.position,
      quaternion: quaternion ?? this.quaternion,
      velocity: velocity ?? this.velocity,
      angularVelocity: angularVelocity ?? this.angularVelocity);
  }
  
  Die copyWithModelFieldValues({
    ModelFieldValue<Vector3?>? position,
    ModelFieldValue<DieQuaternion?>? quaternion,
    ModelFieldValue<Vector3?>? velocity,
    ModelFieldValue<Vector3?>? angularVelocity
  }) {
    return Die._internal(
      position: position == null ? this.position : position.value,
      quaternion: quaternion == null ? this.quaternion : quaternion.value,
      velocity: velocity == null ? this.velocity : velocity.value,
      angularVelocity: angularVelocity == null ? this.angularVelocity : angularVelocity.value
    );
  }
  
  Die.fromJson(Map<String, dynamic> json)  
    : _position = json['position'] != null
          ? json['position']['serializedData'] != null
              ? Vector3.fromJson(new Map<String, dynamic>.from(json['position']['serializedData']))
              : Vector3.fromJson(new Map<String, dynamic>.from(json['position']))
        : null,
      _quaternion = json['quaternion'] != null
          ? json['quaternion']['serializedData'] != null
              ? DieQuaternion.fromJson(new Map<String, dynamic>.from(json['quaternion']['serializedData']))
              : DieQuaternion.fromJson(new Map<String, dynamic>.from(json['quaternion']))
        : null,
      _velocity = json['velocity'] != null
          ? json['velocity']['serializedData'] != null
              ? Vector3.fromJson(new Map<String, dynamic>.from(json['velocity']['serializedData']))
              : Vector3.fromJson(new Map<String, dynamic>.from(json['velocity']))
        : null,
      _angularVelocity = json['angularVelocity'] != null
          ? json['angularVelocity']['serializedData'] != null
              ? Vector3.fromJson(new Map<String, dynamic>.from(json['angularVelocity']['serializedData']))
              : Vector3.fromJson(new Map<String, dynamic>.from(json['angularVelocity']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'position': _position?.toJson(), 'quaternion': _quaternion?.toJson(), 'velocity': _velocity?.toJson(), 'angularVelocity': _angularVelocity?.toJson()
  };
  
  Map<String, Object?> toMap() => {
    'position': _position,
    'quaternion': _quaternion,
    'velocity': _velocity,
    'angularVelocity': _angularVelocity
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Die";
    modelSchemaDefinition.pluralName = "Dice";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'position',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Vector3')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'quaternion',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'DieQuaternion')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'velocity',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Vector3')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'angularVelocity',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Vector3')
    ));
  });
}