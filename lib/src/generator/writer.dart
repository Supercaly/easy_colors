import 'color_variable.dart';

/// Returns the generated colors file as a [String].
String write(List<ColorVariable> colorVariables) {
  String gFile = '''
// DO NOT EDIT. This is code generated via package:easy_colors/generate.dart

import 'package:flutter/painting.dart';

''';

  gFile += '''
class EasyColors {
  const EasyColors._();
  
''';
  for (var c in colorVariables) {
    final colorStr = '''
  static const Color ${c.name} = ${c.color};
''';
    gFile += colorStr;
  }
  gFile += '}\n';
  return gFile;
}
