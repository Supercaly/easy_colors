import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'src/generator_options.dart';
import 'src/exceptions.dart';
import 'src/parser.dart';
import 'src/writer.dart';

void main(List<String> args) {
  final genOptions = GeneratorOptions();
  final argParser = _generateArgParser(genOptions);

  // Check if the command contains an help
  if (args.length == 1 && (args[0] == '-h' || args[0] == '--help')) {
    print(argParser.usage);
  } else {
    try {
      argParser.parse(args);
      _generate(genOptions);
    } on FormatException catch (e) {
      print('\u001b[31m[ERROR] easy colors: ${e.message}\u001b[0m');
      print("");
      print(argParser.usage);
    }
  }
}

/// Generate an [ArgParser] based on some [options].
ArgParser _generateArgParser(GeneratorOptions options) {
  final parser = ArgParser();
  parser.addOption(
    'source-dir',
    abbr: 'S',
    defaultsTo: 'assets',
    help: "Folder of the colors file.",
    callback: (String x) => options.inputDir = x,
  );
  parser.addOption(
    'source-file',
    abbr: 's',
    defaultsTo: 'colors.json',
    help: "File .json with the colors.",
    callback: (String x) => options.inputName = x,
  );
  parser.addOption(
    'output-dir',
    abbr: 'O',
    defaultsTo: 'lib/generated',
    help: "Folder where the generated file is stored.",
    callback: (String x) => options.outputDir = x,
  );
  parser.addOption(
    'output-file',
    abbr: 'o',
    defaultsTo: 'gen_colors.g.dart',
    help: "Name of the generated file",
    callback: (String x) => options.outputName = x,
  );
  return parser;
}

/// Start the file generation process
Future<void> _generate(GeneratorOptions options) async {
  try {
    final current = Directory.current;
    final source = Directory.fromUri(Uri.parse(options.inputDir));
    final output = Directory.fromUri(Uri.parse(options.outputDir));
    final sourceFile =
        File(path.join(current.path, source.path, options.inputName));
    final outputFile =
        File(path.join(current.path, output.path, options.outputName));

    if (!options.inputName.endsWith('.json'))
      throw FileException("Input file must be a .json file!");
    if (!await sourceFile.exists())
      throw FileException("Unknown file '${sourceFile.path}'");

    final parsed = parseJsonString(await sourceFile.readAsString());
    final written = write(parsed);

    if (!await outputFile.exists()) await outputFile.create(recursive: true);
    await outputFile.writeAsString(written);

    print(
        '\u001b[32measy colors: All done! File generated in ${outputFile.path}\u001b[0m');
  } on ParseException catch (ex) {
    print('\u001b[31m[ERROR] easy colors: $ex\u001b[0m');
  } on FileException catch (ex) {
    print('\u001b[31m[ERROR] easy colors: $ex\u001b[0m');
  } catch (e) {
    print("Unknown error occurred! $e");
  }
}
