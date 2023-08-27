import 'package:flutter/material.dart';

import 'package:circulito/circulito.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circulito basic example')),
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            color: Colors.grey.shade200,
            child: Circulito(
              maxSize: 280,
              strokeWidth: 20,
              padding: const EdgeInsets.all(20),
              strokeCap: CirculitoStrokeCap.round,
              backgroundColor: Colors.grey,
              sections: [
                // Male percentage.
                CirculitoSection(color: Colors.blue, percentage: 0.45),

                // Female percentage.
                CirculitoSection(color: Colors.pink, percentage: 0.35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
