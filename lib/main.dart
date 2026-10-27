import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide + Scale + Fade Demo')),
        body: const Center(child: SlidingScalingFadingContainer()),
      ),
    );
  }
}

class SlidingScalingFadingContainer extends StatefulWidget {
  const SlidingScalingFadingContainer({super.key});

  @override
  State<SlidingScalingFadingContainer> createState() =>
      _SlidingScalingFadingContainerState();
}

class _SlidingScalingFadingContainerState
    extends State<SlidingScalingFadingContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Container moves vertically (top → bottom)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // start above
      end: const Offset(0.0, 1.0),    // move below
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Text scales in/out
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Container fades in/out
    _fadeAnimation = Tween<double>(
      begin: 0.2, // almost invisible
      end: 1.0,   // fully visible
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Repeat animation back and forth
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: 220,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const Text(
              '246Y1A6208',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}



