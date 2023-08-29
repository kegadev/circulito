# Circulito

Circulito provides a simple circular wheel chart for visualizing data using percentages and colors.

<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/263871505-d39bc60c-261f-448f-91a6-5605ad1e4f2d.png' alt='example circle wheel'>

</div>

## Features

- Display circular wheel charts with customizable sections.
- Easily visualize data by providing percentages and corresponding colors.

## Getting started

Add the package to your pubspec.yaml file:

```yml
dependencies:
  circulito: ^0.0.3
```

## Usage

Use the Circulito widget in your Flutter app:

```dart
Circulito(
   maxSize: 500,
   strokeWidth: 50,
   backgroundColor: Colors.grey,
   padding: const EdgeInsets.all(20),
   strokeCap: CirculitoStrokeCap.round,
   sections: [
     // Male percentage.
     CirculitoSection(color: Colors.blue, percentage: 0.45),

     // Female percentage.
     CirculitoSection(color: Colors.pink, percentage: 0.35),
   ],
 ),
```

### Parameters

`maxSize`: The maximum size the widget can grow inside its parent.

`strokeWidth`: The width of the stroke that defines the chart's outline.

`strokeCap`: The type of cap to use for the stroke (round or butt).

`backgroundColor`: The background color of the wheel to be painted.

`padding:` The padding to be applied to the widget.

`sections`: A list of CirculitoSection objects representing each chart section.

`isCentered:` Whether the widget should be centered or not inside the parent widget.

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.
<br><br>

<div align="center">
  <a href="https://www.buymeacoffee.com/kegadev">
    <img src="https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&emoji=&slug=kegadev&button_colour=FFDD00&font_colour=000000&font_family=Arial&outline_colour=000000&coffee_colour=ffffff" alt="Buy Me a Coffee">
  </a>
</div>
