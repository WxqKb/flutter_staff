import 'dart:math';

import 'package:flutter/material.dart';

class LikeHandel extends StatefulWidget {
  const LikeHandel(
      {Key? key, required this.activeChild, required this.normalChild})
      : super(key: key);

  final Widget activeChild;
  final Widget normalChild;

  @override
  _LikeHandelState createState() => _LikeHandelState();
}

class _LikeHandelState extends State<LikeHandel> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;
  late AnimationController _circleController;
  late Animation _circleAnimation;
  bool active = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _iconAnimation = Tween(begin: 1.0, end: 1.3).animate(_animationController);

    _iconAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(_animationController);

    _circleController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _circleAnimation = Tween(begin: 1.0, end: 0.0).animate(_circleController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_iconAnimation.status == AnimationStatus.forward ||
            _iconAnimation.status == AnimationStatus.reverse) {
          return;
        }
        setState(() {
          active = !active;
        });
        if (_iconAnimation.status == AnimationStatus.dismissed) {
          _animationController.forward();
        } else if (_iconAnimation.status == AnimationStatus.completed) {
          _animationController.reverse();
        }
        if (active) {
          _circleController.reset();
          _circleController.forward();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScaleTransition(
              scale: _iconAnimation,
              child: active ? widget.activeChild : widget.normalChild),
          _buildCirclePoints(),
        ],
      ),
    );
  }

  _buildCirclePoints() {
    return Flow(
      delegate: CirclePointFlowDelegate(),
      children: <Widget>[
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Colors.blue),
      ],
    );
  }

  _buildCirclePoint(double radius, Color color) {
    return !active
        ? Container()
        : AnimatedBuilder(
            animation: _circleAnimation,
            builder: (BuildContext context, _) {
              return Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(_circleAnimation.value)),
              );
            },
          );
  }
}

class CirclePointFlowDelegate extends FlowDelegate {
  CirclePointFlowDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {
    var radius = min(context.size.width, context.size.height) / 2.0;
    //中心点
    double rx = radius;
    double ry = radius;
    for (int i = 0; i < context.childCount; i++) {
      if (i % 2 == 0) {
        double x =
            rx + (radius - 5) * cos(i * 2 * pi / (context.childCount - 1));
        double y =
            ry + (radius - 5) * sin(i * 2 * pi / (context.childCount - 1));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      } else {
        double x = rx +
            (radius - 5) *
                cos((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        double y = ry +
            (radius - 5) *
                sin((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
