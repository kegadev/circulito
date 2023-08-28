# Circulito

Circulito is a Flutter package that provides a simple circular wheel chart for visualizing data using percentages and colors.

## Features

Display circular wheel charts with customizable sections.
Easily visualize data by providing percentages and corresponding colors.

## Getting started

Add the package to your pubspec.yaml file:

```yml
dependencies:
  circulito: ^0.0.2
```

## Usage

Use the Circulito widget in your Flutter app:

```dart
Circulito(
  radius: 180,
  strokeWidth: 25,
  strokeCap: CirculitoStrokeCap.round,
  backgroundColor: Colors.white,
  sections: [
    // Male percentage.
    CirculitoSection(color: Colors.blue, percentage: 0.45),
    // Female percentage.
    CirculitoSection(color: Colors.pink, percentage: 0.35),
  ],
)
```

### Parameters

`radius`: The radius of the circular chart.

`strokeWidth`: The width of the stroke that defines the chart's outline.

`strokeCap`: The type of cap to use for the stroke (round or butt).

`backgroundColor`: The color of the chart's background.

`sections`: A list of CirculitoSection objects representing each chart section.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
