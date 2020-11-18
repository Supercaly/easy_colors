import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'color_variable.dart';

/// Returns the generated colors file as a [String].
String write(List<ColorVariable> colorVariables) {
  final List<Field> fields = [];
  for (var c in colorVariables) {
    fields.add(Field((f) => f
      ..name = c.name
      ..static = true
      ..modifier = FieldModifier.constant
      ..type = refer('Color')
      ..assignment = Code(c.color)));
  }

  final clazz = Class((b) => b
    ..name = "GeneratedEasyColors"
    ..fields.addAll(fields)
    ..constructors.add(Constructor((c) => c
      ..constant = true
      ..name = "_")));

  return '''
// DO NOT EDIT. This is code generated via package:easy_colors/generate.dart

import 'package:flutter/painting.dart';

${DartFormatter().format("${clazz.accept(DartEmitter())}")}''';
}
