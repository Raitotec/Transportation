
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AnimatedGridIcon extends StatefulWidget {
  final Widget widget;
  final AsyncCallback onTapped;
  //final AsyncValueSetter<int> onTapped ;

  AnimatedGridIcon({Key? key,required this.widget,required this.onTapped});
  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedGridIcon>
    with SingleTickerProviderStateMixin {
  bool _enabled=true;


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
      ScaleAnimatedWidget.tween(
        enabled: this._enabled,
        duration: Duration(milliseconds: 50),
        scaleDisabled: 0.7,
        scaleEnabled: 1,
        //your widget
        child: GestureDetector(
                  child: widget.widget,
                  onTap: () async {
                   // runAnimation();
                    setState(() {
                      _enabled = !_enabled;
                    });
                    await Future.delayed( Duration(milliseconds: 70), ()
                    async {
                    //    Navigator.pushNamedAndRemoveUntil(context, homeRoute,(Route<dynamic> r)=>false);
                      setState(() {
                        _enabled = !_enabled;
                      });
                     await widget.onTapped();

                    });
                  }
            ),
    ));
  }
}