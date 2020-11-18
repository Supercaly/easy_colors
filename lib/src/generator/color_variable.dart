/// Class representing a single color variable that
/// needs to be generated.
class ColorVariable {
  /// Name of the variable.
  final String name;

  /// Color value.
  final String color;

  ColorVariable(this.name, this.color);

  @override
  String toString() {
    return 'ColorVariable{name: $name, color: $color}';
  }
}
