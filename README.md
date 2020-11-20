# Easy Colors

## Why easy_colors?

This package has the purpose to help manage all the color resources used inside a Flutter app in 
a simple and fast way without the hassle of creating dart files.

## Getting Started

### Installation

Add `easy_colors` to your `pubspec.yaml` file.

```yaml
dependencies:
    easy_colors: <latest-version>
```

Create a file `.json` where all the colors will be declared

Example:

```
assets
└── colors.json
```

### Content of the colors file

Inside your `colors.json` file you will declare all your colors as a *key-value* pair where the 
key is the color name and the value is the color.

**NOTE:** The color value can be one of:

- A String with the Hex color code in format RGB (`#RRGGBB`)  
- A String with the Hex color code in format ARGB (`#AARRGGBB`)  
- A integer with the lower 32-bit representing the color in ARGB format

Example:

```json
{
  "red": "#FF0000",
  "green": "#00FF00",
  "blue": "#0000FF",
  "black": "#FF000000",
  "white": "4294967295"
}
```

### Code Generation

After all the steps above are completed you are ready to execute the code generation

Steps:
1. Open your terminal in the folder's path containing your project 
2. Run in terminal ```flutter pub run easy_colors:generate```
3. Use the colors in your app 

```dart
Widget build() {
  //...
  return Container(
    color: EasyColors.red
  );
}
```

4. All done!

For more information run in your terminal ```flutter pub run easy_colors:generate -h```

#### Command-line arguments

| Arguments | Short |  Default | Description |
| ------ | ------ |  ------ | ------ |
| --help | -h |  | Help info |
| --source-dir | -S | assets | Folder containing color file |
| --source-file | -s | colors.json | File to use for generation |
| --output-dir | -O | lib/generated | Output folder where the generated file is stored |
| --output-file | -o | gen_colors.g.dart | Output file name | 

## To Do Features

- [x] Parse colors in hex string format (`#AARRGGBB`)
- [x] Parse colors in int format (`4294967295`)
- [] Parse colors in RGB list format (`[255, 0, 0]`)
- [] Parse colors in ARGB list format (`[255, 255, 0, 0]`)
- [] Parse colors in HSL list format (`[10, 0, 0]`)
- [] Parse colors in CMYK list format (`[100, 100, 100, 100]`)
