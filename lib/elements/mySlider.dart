import 'package:flutter/material.dart';

class MySlider extends MaterialPageRoute{

  MySlider({WidgetBuilder builder, RouteSettings settings})
      :super( builder : builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom = Tween<Offset>(begin: Offset(1.5, 0.0), end: Offset(0.0, 0.0)).animate(animation);
    return SlideTransition(position: custom, child: child);
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}

class MySliderF extends MaterialPageRoute{

  MySliderF({WidgetBuilder builder, RouteSettings settings})
      :super( builder : builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation);
    return SlideTransition(position: custom, child: child);
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}


class MySliderAdd extends MaterialPageRoute{

  MySliderAdd({WidgetBuilder builder, RouteSettings settings})
      :super( builder : builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation);
    return SlideTransition(position: custom, child: child);
    //return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}
class MySliderPosts extends MaterialPageRoute{

  MySliderPosts({WidgetBuilder builder, RouteSettings settings})
      :super( builder : builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return new ScaleTransition(
      scale: new Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.00,
            0.50,
            curve: Curves.linear,
          ),
        ),
      ),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.50,
              1.00,
              curve: Curves.linear,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}