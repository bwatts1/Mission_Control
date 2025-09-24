import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  bool active = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        active = false;
      }
      if (active == true) {
        _counter -= 1;
      }
    };
  }
  void _activate() {
    setState(() {
      active = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
        children: [
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40), // spacing between counter and slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _counter = value.toInt();
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),
          ),
          ElevatedButton(onPressed: _activate, child: const Text('Launch')),
        ],
      ),
    );
  }
}
