import 'dart:convert';

import 'color_variable.dart';
import 'exceptions.dart';

/// Parse the [name] of the color and converts
/// it into a camelCase string if case it is a
/// snake_case string.
String parseName(String name) {
  return name.splitMapJoin(
    RegExp(r'[-_][a-zA-Z0-9]'),
    onMatch: (m) => m[0]!.substring(1).toUpperCase(),
    onNonMatch: (nm) => nm,
  );
}

/// Parse a color value from json to a string
/// with dart's color like: `Color(0xFF000000)`.
///
/// A color value form json can be a string with the hex
/// value (`#FF00FF00` or `#FF00FF`) or a 32-bit int.
///
/// Throws [ParseException].
String parseColor(dynamic value) {
  int? colorValue;
  if (value is String) {
    if (value.isEmpty) throw ParseException("A color hex can't be empty!");
    final buffer = StringBuffer();
    if (value.length == 6 || value.length == 7) buffer.write("FF");
    buffer.write(value.replaceFirst("#", ""));
    colorValue = int.parse(buffer.toString(), radix: 16);
  } else if (value is int) {
    colorValue = value;
  } else
    throw ParseException("A color can be only a hex string or an int!");
  return "Color($colorValue)";
}

/// Parse a json string into a list of [ColorVariable].
///
/// Throws [ParseException].
List<ColorVariable> parseJsonString(String input) {
  Map<String, dynamic> jsonColors;
  try {
    jsonColors = json.decode(input);
  } on FormatException catch (e) {
    throw ParseException(e.message);
  }
  final List<ColorVariable> result = [];

  for (var kv in jsonColors.entries) {
    result.add(ColorVariable(parseName(kv.key), parseColor(kv.value)));
  }
  return result;
}
