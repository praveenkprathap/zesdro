// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ZoomInOutWidget extends StatefulWidget {
  final Widget child;

  const ZoomInOutWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _ZoomInOutWidgetState createState() => _ZoomInOutWidgetState();
}

class _ZoomInOutWidgetState extends State<ZoomInOutWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300)).then((value) =>
            _controller.reverse().then((value) => _controller.stop()));
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
