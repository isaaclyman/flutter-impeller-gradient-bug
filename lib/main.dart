import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Impeller Gradient Bug',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      home: const FlutterImpellerGradientBug(),
    );
  }
}

class FlutterImpellerGradientBug extends StatefulWidget {
  final color1 = Colors.red;
  final color2 = Colors.green;

  const FlutterImpellerGradientBug({super.key});

  @override
  State<FlutterImpellerGradientBug> createState() =>
      _FlutterImpellerGradientBugState();
}

class _FlutterImpellerGradientBugState
    extends State<FlutterImpellerGradientBug> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                widget.color1,
                widget.color1,
                widget.color2,
                widget.color2,
              ],
              stops: [
                0.0,
                0.5,
                0.5,
                1.0,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
