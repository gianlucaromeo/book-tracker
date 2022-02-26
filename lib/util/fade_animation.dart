import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {

  late double _opacityFrom; // The opacity to modify
  late double _opacityTo;
  late Duration _duration;
  late Widget _child;


  FadeAnimation({Key? key, required double opacityFrom, required double opacityTo, required Widget child, required Duration duration}) : super(key: key) {
    _opacityFrom = opacityFrom;
    _opacityTo = opacityTo;
    _child = child;
    _duration = duration;
  }

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {

  _changeOpacity() {
    Future.delayed(widget._duration, () {
      setState(() {
        widget._opacityFrom = widget._opacityTo;
        _changeOpacity();
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
      opacity: widget._opacityFrom,
      duration: widget._duration,
      child: widget._child,
    );
  }

}