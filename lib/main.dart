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
  int progress = 0;
  bool active = false;
  Timer? _timer;
  Color color = Colors.red;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter == 0) {
        active = false;
        }
        if (active == true) {
          progress +=1;
          _counter -= 1;
          _colorChange();
        }});
    });
  }
  void _fuel() {
    setState(() {
      if (_counter <= 100 && active == false) {
        _counter+=1;
        _colorChange();
      }
      else{
        active = true;
      }
    });
  }
  void _ignite() {
    setState(() {
      if (_counter > 50) {
        (active = true);
      } else {
      }
    });
  }
  void _abort() {
    setState(() {
      active = false;
      _counter = 0;
      _colorChange();
    });
  }
  void _reset() {
    setState(() {
      active = false;
      _counter = 0;
      progress = 0;
      _colorChange();
    });
  }
  void _defuel() {
    setState(() {
      if (_counter < 1) {
        active = false;
      }
      if (active == true) {
        _counter-=1;
        _colorChange();
      }
    });
  }
  
  void _colorChange() {
    setState(() {
      if (_counter > 50) {
        color = Colors.green;
      } else {
        color = Colors.red;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
        children: [
          Text(
            '$_counter',
            style: TextStyle(fontSize: 50.0, color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40), // spacing between counter and slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: null,
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _ignite, child: const Text('Ignite')),
              ElevatedButton(onPressed: _fuel, child: const Text('Fuel')),
              ElevatedButton(onPressed: _defuel, child: const Text('Defuel')),
              ElevatedButton(onPressed: _abort, child: const Text('Abort')),
              ElevatedButton(onPressed: _reset, child: const Text('Reset'))
            ],
          ),
        ],
      ),
    );
  }
}
