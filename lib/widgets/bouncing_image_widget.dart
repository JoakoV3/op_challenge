import 'package:flutter/material.dart';

class BouncingImageWidget extends StatefulWidget {
  const BouncingImageWidget({super.key});

  @override
  State<BouncingImageWidget> createState() => _BouncingImageWidgetState();
}

class _BouncingImageWidgetState extends State<BouncingImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Image.asset(
            'assets/star-wars.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
