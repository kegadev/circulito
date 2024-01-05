import 'package:flutter/material.dart';

import 'package:example/examples/examples.dart';

import 'widgets/about_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Controller for the PageView.
  late PageController _pageController;
  final _pageControllerKey = GlobalKey();

  /// List of Circulito examples.
  ///
  /// Check the `examples` folder to see the code of each one.
  static const _circulitoExamples = [
    Genders(),
    AppleFitnessRings(),
    CountDown(),
    DynamicRing(),
  ];

  /// List of items for the bottom navigation bar.
  static const _bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.male), label: 'Simple'),
    BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp), label: 'Triple'),
    BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
    BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Dynamic'),
  ];

  static const _titles = [
    'Genders simple example',
    'Apple-like rings',
    '10 seconds countdown',
    'Dynamic Pie chart',
  ];

  /// If the about widget should be shown.
  var _canShowAbout = false;

  /// Index of the current page.
  var _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            _canShowAbout ? 'About Circulito' : _titles[_pageIndex],
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              tooltip: _canShowAbout ? 'Go back' : 'About',
              onPressed: () => setState(() {
                _canShowAbout = !_canShowAbout;
                _pageController = PageController(initialPage: _pageIndex);
              }),
              icon: const Icon(Icons.lightbulb),
              color: _canShowAbout ? Colors.amberAccent : Colors.white,
            )
          ],
        ),
        backgroundColor:
            _pageIndex == 1 && !_canShowAbout ? Colors.black : Colors.white,
        body: _canShowAbout
            ? const AboutWidget()
            : PageView(
                key: _pageControllerKey,
                onPageChanged: _onPageChanged,
                controller: _pageController,
                children: _circulitoExamples,
              ),
        bottomNavigationBar: _canShowAbout
            ? null
            : BottomNavigationBar(
                items: _bottomItems,
                currentIndex: _pageIndex,
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                onTap: _onBottomTap,
              ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  void _onBottomTap(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
