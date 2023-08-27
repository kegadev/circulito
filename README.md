# Circulito

This Package allows to insert a simple Circular wheel chart

## Features

It can receive percentage and colors and show graph

## Getting started

Just import and use

## Usage

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

## Additional information

See example to know more.
