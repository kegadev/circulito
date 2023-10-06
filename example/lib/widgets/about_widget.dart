import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});
  static const _titleStyle = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Top message.
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Tap again to go back ⬆️',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),

        // About text.
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText('About', style: _titleStyle),
                  SizedBox(height: 10.0),
                  SelectableText(
                      'Circulito is a Flutter package,highly customizable to draw circular charts or wheels. '
                      'It can be found at: https://pub.dev/packages/circulito.\n\n'
                      'This example app shows some of the things you can do with Circulito like:\n'
                      '• Donut and Pie Charts.\n'
                      '• Apple-like Fitness rings.\n'
                      '• Countdowns.\n'
                      '• Dynamic charts with animated sections.\n'),
                  SizedBox(height: 30.0),
                  SelectableText('Disclaimer', style: _titleStyle),
                  SizedBox(height: 10.0),
                  SelectableText('This is not an official Apple product.\n'
                      'This is just an example of what can be achieved with Circulito.\n'
                      'The Apple Fitness rings are a registered trademark of Apple Inc.'),
                  SizedBox(height: 30.0),
                  SelectableText('Developer', style: _titleStyle),
                  SizedBox(height: 10.0),
                  SelectableText('Made with ❤️ by Kevin Garcia:\n'
                      'More about me: https://kega.dev\n'
                      'Social media:    @kegadev\n'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
