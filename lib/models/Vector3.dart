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


/** This is an auto generated class representing the Vector3 type in your schema. */
class Vector3 {
  final double? _x;
  final double? _y;
  final double? _z;

  double? get x {
    return _x;
  }
  
  double? get y {
    return _y;
  }
  
  double? get z {
    return _z;
  }
  
  const Vector3._internal({x, y, z}): _x = x, _y = y, _z = z;
  
  factory Vector3({double? x, double? y, double? z}) {
    return Vector3._internal(
      x: x,
      y: y,
      z: z);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Vector3 &&
      _x == other._x &&
      _y == other._y &&
      _z == other._z;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Vector3 {");
    buffer.write("x=" + (_x != null ? _x!.toString() : "null") + ", ");
    buffer.write("y=" + (_y != null ? _y!.toString() : "null") + ", ");
    buffer.write("z=" + (_z != null ? _z!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Vector3 copyWith({double? x, double? y, double? z}) {
    return Vector3._internal(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z);
  }
  
  Vector3 copyWithModelFieldValues({
    ModelFieldValue<double?>? x,
    ModelFieldValue<double?>? y,
    ModelFieldValue<double?>? z
  }) {
    return Vector3._internal(
      x: x == null ? this.x : x.value,
      y: y == null ? this.y : y.value,
      z: z == null ? this.z : z.value
    );
  }
  
  Vector3.fromJson(Map<String, dynamic> json)  
    : _x = (json['x'] as num?)?.toDouble(),
      _y = (json['y'] as num?)?.toDouble(),
      _z = (json['z'] as num?)?.toDouble();
  
  Map<String, dynamic> toJson() => {
    'x': _x, 'y': _y, 'z': _z
  };
  
  Map<String, Object?> toMap() => {
    'x': _x,
    'y': _y,
    'z': _z
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Vector3";
    modelSchemaDefinition.pluralName = "Vector3s";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'x',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'y',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'z',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
  });
}