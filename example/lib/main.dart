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
            width: 480,
            height: 480,
            color: Colors.grey.shade200,
            child: Circulito(
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
              child: const Center(child: Text('Genders')),
            ),
          ),
        ),
      ),
    );
  }
  // Container(width: 150, height: 50, color: Colors.green),
}
