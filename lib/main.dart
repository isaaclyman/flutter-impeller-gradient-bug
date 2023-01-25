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
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          FlutterImpellerGradientBug(),
          _FlutterImpellerAnimatedGradientBug(),
        ],
      ),
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
              stops: const [
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

class _FlutterImpellerAnimatedGradientBug extends StatefulWidget {
  final color1 = Colors.red;
  final color2 = Colors.green;

  const _FlutterImpellerAnimatedGradientBug();

  @override
  State<_FlutterImpellerAnimatedGradientBug> createState() =>
      _FlutterImpellerAnimatedGradientBugState();
}

class _FlutterImpellerAnimatedGradientBugState
    extends State<_FlutterImpellerAnimatedGradientBug>
    with TickerProviderStateMixin {
  late final AnimationController _animation =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);

  @override
  void initState() {
    super.initState();
    _animation.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              final animationProgress =
                  Tween(begin: 0.0, end: 1.0).evaluate(_animation);
              return DecoratedBox(
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
                      animationProgress,
                      animationProgress,
                      1.0,
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
