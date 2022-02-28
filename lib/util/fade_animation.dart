import 'package:flutter/material.dart';

class FadeInAnimation extends FadeAnimation {
  FadeInAnimation({Key? key, required int milliseconds, required Widget child})
      : super(
            key: key,
            opacityFrom: 0.0,
            opacityTo: 1.0,
            milliseconds: milliseconds,
            child: child);
}

class FadeAnimation extends StatefulWidget {

  late final double _opacityFrom; // The opacity to modify
  late final double _opacityTo;
  late final Duration _duration;
  late final Widget _child;

  FadeAnimation(
      {Key? key,
      required double opacityFrom,
      required double opacityTo,
      required Widget child,
      required int milliseconds})
      : super(key: key) {
    _opacityFrom = opacityFrom;
    _opacityTo = opacityTo;
    _child = child;
    _duration = Duration(milliseconds: milliseconds);
  }

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {

  late double _opacity = widget._opacityFrom;

  _changeOpacity() {
    Future.delayed(widget._duration, () {
      setState(() {
        _opacity = widget._opacityTo;
      });
    });
  }

  @override
  void initState() {
    _changeOpacity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget._duration,
      child: widget._child,
    );
  }
}
