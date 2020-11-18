import 'package:easy_colors/src/generator/exceptions.dart';
import 'package:easy_colors/src/generator/parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Json Parser Tests", () {
    test("parse empty json", () {
      try {
        parseJsonString("");
        fail("This test should throw an error!");
      } catch (e) {
        expect(e, isA<ParseException>());
        expect(
            (e as ParseException).message, contains("Unexpected end of input"));
      }
    });

    test("parse json with error", () {
      try {
        parseJsonString('''
        {
          "color_1"
        }
        ''');
        fail("This test should throw an error!");
      } catch (e) {
        expect(e, isA<ParseException>());
        expect((e as ParseException).message, contains("Unexpected character"));
      }
    });

    test("parse correct json", () {
      final parsed = parseJsonString('{"color_1": "#FF0000"}');

      expect(parsed, isNotEmpty);
      expect(parsed.first.name, "color1");
      expect(parsed.first.color, "Color(0xFFFF0000)");
    });
  });

  group("Color Parser Tests", () {
    test("parse a correct int color", () {
      final result = parseColor(4294967295);
      expect(result, equals("Color(4294967295)"));
    });

    test("parse a correct string color", () {
      final res1 = parseColor("#FF123456");
      final res2 = parseColor("#123456");

      expect(res1, equals("Color(0xFF123456)"));
      expect(res2, equals("Color(0xFF123456)"));
    });

    test("parse a string color defined without a #", () {
      try {
        parseColor('FF0000');
        fail("This should throw an error!");
      } catch (e) {
        expect(e, isA<ParseException>());
        expect((e as ParseException).message,
            equals("Color FF0000 does not start with # character!"));
      }
    });

    test("parse a string color with wrong length", () {
      try {
        parseColor('#F0000');
        fail("This should throw an error!");
      } catch (e) {
        expect(e, isA<ParseException>());
        expect((e as ParseException).message,
            equals("Hex color must be in the form #FFCD5C5C or #CD5C5C"));
      }
    });

    test("parsing a color in an unsupported type throws an error", () {
      try {
        parseColor([100, 255, 255]);
        fail("This should throw an error!");
      } catch (e) {
        expect(e, isA<ParseException>());
        expect((e as ParseException).message,
            equals("A color can be only a hex string or an int!"));
      }
    });
  });

  group("Name Parser Tests", () {
    test("parse snake case name", () {
      expect(parseName("snake_case_1"), equals("snakeCase1"));
      expect(parseName("snake-case_200"), equals("snakeCase200"));
    });

    test("parse single word name", () {
      expect(parseName("colorname"), equals("colorname"));
    });
  });
}
