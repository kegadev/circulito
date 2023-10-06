import 'package:flutter/material.dart';

import 'package:example/examples/apple_fitness_rings.dart';
import 'package:example/examples/count_down.dart';
import 'package:example/examples/dynamic_ring.dart';
import 'package:example/examples/genders.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController _pageController;

  var _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bottomItems = [
      BottomNavigationBarItem(icon: Icon(Icons.male), label: 'Simple'),
      BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp), label: 'Triple'),
      BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
      BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Dynamic'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Circulito basic examples'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: _pageIndex == 1 ? Colors.black : Colors.white,
        body: PageView(
          controller: _pageController,
          children: const [
            Genders(),
            AppleFitnessRings(),
            CountDown(),
            DynamicRing(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          items: bottomItems,
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() => _pageIndex = index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn,
            ); // Animate the PageView to the selected page
          },
        ),
      ),
    );
  }
}
