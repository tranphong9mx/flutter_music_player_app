import 'dart:math';

import 'package:flutter/material.dart';

enum MusicButtonType {
  NEXT_SONG,
  PREV_SONG,
  SKIP_NEXT,
  SKIP_PREV,
  REPEAT,
  SHUFFLE,
  PLAY
}
class MusicEffectButton extends StatefulWidget {
  MusicEffectButton({
    Key key,
    this.onTap,
    this.type = MusicButtonType.REPEAT,
    @required this.child,
  }) : super(key: key);
  final Widget child;
  final Function onTap;
  final MusicButtonType type;
  @override
  _MusicEffectButtonState createState() => _MusicEffectButtonState();
}
class _MusicEffectButtonState extends State<MusicEffectButton>
    with TickerProviderStateMixin {
  static const _translateValue = 6.0;
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  // Animation follow button type
  getWidget() {
    switch (widget.type) {
      case MusicButtonType.PREV_SONG:
      case MusicButtonType.NEXT_SONG:
        return Transform.translate(
            offset: Offset(
                _animation.value *
                    _translateValue *
                    () {
                      return widget.type == MusicButtonType.NEXT_SONG ? 1 : -1;
                    }(),
                0),
            child: widget.child);
        break;
      case MusicButtonType.SKIP_PREV:
      case MusicButtonType.SKIP_NEXT:
        return Transform.rotate(
            angle: pi *
                _animation.value *
                () {
                  return widget.type == MusicButtonType.SKIP_PREV
                      ? -1 / 4
                      : 1 / 4;
                }(),
            child: widget.child);
        break;
      case MusicButtonType.SHUFFLE:
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(pi * _animation.value),
            child: widget.child);
        break;
      default:
        return Transform.scale(
            scale: 0.2 * _animation.value + 1, child: widget.child);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: widget.onTap,
            onTapUp: _onTapUp,
            onTapDown: _onTapDown,
            child: getWidget()));
  }
}
