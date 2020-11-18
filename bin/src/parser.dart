import 'dart:convert';

import 'color_variable.dart';
import 'exceptions.dart';

/// Parse a color value from json to a string
/// with dart's color like: `Color(0xFF000000)`.
///
/// A color value form json can be a string with the hex
/// value (`#FF00FF00` or `#FF00FF`) or a 32-bit int.
String parseColor(dynamic value) {
  String colorValue = '';
  if (value is String) {
    String sValue = value.trim();
    // Check that the value is a correct hex string
    if (!sValue.startsWith('#'))
      throw ParseException("Color $sValue does not start with # character!");
    sValue = sValue.substring(1);
    // A valid hex color has length 6 or 8 (can have alpha or not)
    if (sValue.length != 6 && sValue.length != 8)
      throw ParseException("Hex color must be in the form #FFCD5C5C or #CD5C5C");
    if (sValue.length == 6) sValue = "FF$sValue";

    colorValue = "0x${sValue.toUpperCase()}";
  } else if (value is int) {
    colorValue = value.toString();
  } else
    throw ParseException("A color value can be only a hex string or an int!");
  return "Color($colorValue)";
}

/// Parse a json string into a list of [ColorVariable].
List<ColorVariable> parseJsonString(String input) {
  final Map<String, dynamic> jsonColors = json.decode(input);
  final List<ColorVariable> result = [];

  for (var kv in jsonColors.entries) {
    result.add(ColorVariable(kv.key, parseColor(kv.value)));
  }

  return result;
}
