# Circulito

_Circulito_ provides a highly customizable way to draw and animate circular wheel/donut/pie chart for visualizing data using percentages and colors.

<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/273652567-26867a46-9a28-493f-bdab-07266d8b8c86.png' alt='example circle wheel'>
<!-- <img src='https://user-images.githubusercontent.com/138328831/263871505-d39bc60c-261f-448f-91a6-5605ad1e4f2d.png' alt='example circle wheel'> -->

</div>

## Features

- Display circular wheel/donut/pie charts with customizable sections.
- Easily visualize data by providing amounts or percentages and corresponding colors.
- Gradient decoration on sections and background.
- Interactive sections: `hover` and `onTap` events.
- Multiple levels allowed when added _Circulito_ as a child.
- Animated sections.

## Examples

**Some of the things you can do with Circulito are:**

- Dynamic charts with animated sections.
<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/273652780-5c809b7b-6f28-49f6-b7b6-9febb701e817.png' alt='example circle wheel 2'>
</div>

<br>

- Donut and Pie Charts.
<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/273653288-094ebe2c-438a-4fc0-9961-9d8b10685fec.png' alt='example circle wheel 2'>
</div>

<br>

- Countdowns.
<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/273652764-7a87202f-9a8a-4fe3-88bc-133135483fa9.png' alt='example circle wheel 2'>

</div>

<br>

- Apple-like Fitness rings.

<div align="center">
<img src='https://user-images.githubusercontent.com/138328831/273653562-cb504817-ae98-4af7-8cd4-ad89856713cb.png' alt='example circle wheel 2'>

</div>

<br>

**Online example:**

Check out the online example at [circulito.kega.dev](https://circulito.kega.dev/) to see it in action.

## Getting started

Add the package to your pubspec.yaml file:

```yml
dependencies:
  circulito: ^0.8.0
```

## Usage

Use the _Circulito_ widget in your Flutter app:

```dart
Circulito(
    maxSize: 480,
    padding: 20.0,
    strokeWidth: 80,
    startPoint: StartPoint.left,
    background: CirculitoBackground(),
    strokeCap: CirculitoStrokeCap.round,
    direction: CirculitoDirection.clockwise,
    sectionValueType: SectionValueType.percentage,
    sections: [
        // Male percentage.
        CirculitoSection(
          value: .35,
          color: Colors.blue,
          hoverColor: Colors.blueAccent,
        ),
        // Female percentage.
        CirculitoSection(
          value: .40,
          color: Colors.pink,
          hoverColor: Colors.pinkAccent,
        ),
    ],
);
```

### Amount values

If you want to use _amount_ values instead of _percentages_ just add `sectionValueType` property. The library will automatically calculate the percentages.

```dart
Circulito(
  sectionValueType: SectionValueType.amount,
  sections: [
      CirculitoSection(
        value: 535, // Amount values instead of percentages.
        color: Colors.blue,
      ),
    //...other sections with amount values.
  ]

  // ...other Circulito properties.
);
```

### Animation

To add **Animation** simply add `animation` property:

```dart
Circulito(
  animation: CirculitoAnimation(),
  // ...other Circulito properties.
);
```

You can also configure duration and curve of the animation like this:

```dart
Circulito(
  animation: CirculitoAnimation(
    duration: 200,
    curve: Curves.easeInOut,
  ),
  // ...other Circulito properties.
);
```

### Decoration

The `decoration` property is **required** for both the background and sections in Circulito to display something on the screen. While the background has a default value of grey when using `CirculitoBackground()`, you can customize the decoration with either a `color` or a `gradient`.

```dart
Circulito(
    background: CirculitoBackground(
        // Implement decoration on background with color.
        decoration: CirculitoDecoration.fromColor(
            Colors.white,
            hoverColor: Colors.grey,
        ),
    ),
    sections: [
        CirculitoSection(
            value: 0.5,
            // Implement decoration on a section with gradient.
            decoration: CirculitoDecoration.fromGradient(
                const LinearGradient(colors: [Colors.green, Colors.yellow]),
            ),
      ),
  ]
  // ...other Circulito properties.
);
```

#### Shadow

Add **Shadow** to the _decoration_ for _sections_ or _background_ using `shadow` property:

```dart
decoration: const CirculitoDecoration.fromColor(
    Colors.grey,
    // Default grey shadow.
    shadow: CirculitoShadow(),
),
```

You can also customize the `color`, `spreading` and `style` of the _shadow_.

```dart
decoration: CirculitoDecoration.fromColor(
    Colors.grey,
    // Customized shadow.
    shadow: CirculitoShadow(
        color: Colors.blueGrey.withOpacity(.3),
        spreading: 16.0,
        blurStyle: BlurStyle.normal,
    ),
),
```

#### Border

Add **Border** to the _decoration_ for _sections_ or _background_ using `border` property:

```dart
decoration: const CirculitoDecoration.fromColor(
    Colors.grey,
    // Default black border.
    border: CirculitoBorder(),
),
```

You can also customize the `color` and `size` of the _border_.

```dart
decoration: CirculitoDecoration.fromColor(
    Colors.grey,
    // Customized border.
    border: CirculitoBorder(
        color: Colors.blueGrey,
        size: 8.0,
    ),
),
```

### Section Interactivity

To add **Interactivity** to sections or background just need to add `onHover` or
`onTap` properties to each _CirculitoSection_ widget or _CirculitoBackground_ widget:

```dart
Circulito(
  sections: [
      CirculitoSection(
        ...// required properties
        onHover: _doHoverAction,
        onTap: _doTapAction,
      ),
  ]
  // ...other Circulito properties.
);
```

## Parameters

<!-- Sort alphabetically -->

| Name               | Type                     | Description                                                            |
| ------------------ | ------------------------ | ---------------------------------------------------------------------- |
| `animation`        | `Animation`              | The animation to be applied to the wheel.                              |
| `background`       | `CirculitoAnimation?`    | The background of the wheel to be painted.                             |
| `child`            | `Widget`                 | The widget to be shown over the wheel.                                 |
| `direction`        | `CirculitoDirection`     | Determines the direction of the wheel.                                 |
| `isCentered`       | `bool`                   | Whether the widget should be centered or not inside the parent widget. |
| `maxSize`          | `double`                 | The maximum size the widget can grow inside its parent.                |
| `padding`          | `double?`                | The padding to be applied to the widget.                               |
| `sections`         | `List<CirculitoSection>` | A list of CirculitoSection objects representing each chart section.    |
| `sectionValueType` | `SectionValueType`       | Type of the value of each section (`amount` or `percentage`)           |
| `startPoint`       | `StartPoint`             | Determines the start point of the wheel.                               |
| `strokeCap`        | `CirculitoStrokeCap`     | The type of cap to use for the stroke (`round` or `butt`).             |
| `strokeWidth`      | `double`                 | The width of the stroke that defines the chart's outline.              |

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.
<br><br>

<div align="center">
  <a href="https://www.buymeacoffee.com/kegadev">
    <img src="https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&emoji=&slug=kegadev&button_colour=FFDD00&font_colour=000000&font_family=Arial&outline_colour=000000&coffee_colour=ffffff" alt="Buy Me a Coffee">
  </a>
</div>
