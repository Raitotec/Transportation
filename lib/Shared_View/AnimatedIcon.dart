
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Animated_Icon extends StatefulWidget {
  final Widget widget;
  final AsyncCallback onTapped;

  Animated_Icon({Key? key,required this.widget,required this.onTapped});
  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<Animated_Icon>
    with SingleTickerProviderStateMixin {
  bool _enabled=false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    /*
            RotationTransition(
              turns: Tween(begin: 0.0, end: -0.1).chain(CurveTween(curve: Curves.elasticIn)).animate(_controller),
              child: InkWell(
                child: Icon(Icons.access_alarm,size: 5.0.h,color: Colors.red,),
                onTap: () async {
                runAnimation();
                }
            )*/
      Theme(data: ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent
    ), child:
              ShakeAnimatedWidget(
              enabled: _enabled,
              duration: Duration(milliseconds: 200),
              shakeAngle: Rotation.deg(z: 25),
              curve: Curves.linear,
              child: InkWell(
                  child: widget.widget,
                  onTap: () async {
                   // runAnimation();
                    setState(() {
                      _enabled = true;
                    });
                    Future.delayed( Duration(milliseconds: 400), ()
                    async {
                    //    Navigator.pushNamedAndRemoveUntil(context, homeRoute,(Route<dynamic> r)=>false);

                     await widget.onTapped();
                      setState(() {
                        _enabled = false;
                      });
                    });
                  }
            ),
    ));
  }
}