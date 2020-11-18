/// Class representing an exception during the parse process.
class ParseException {
  /// Error message [String].
  final String message;

  ParseException(this.message);

  @override
  String toString() => message;
}

/// Class representing a file error.
class FileException {
  /// Error message [String].
  final String message;

  FileException(this.message);

  @override
  String toString() => message;
}
