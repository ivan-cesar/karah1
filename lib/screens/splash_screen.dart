import 'package:canteen_food_ordering_app/screens/size_config.dart';
import 'package:canteen_food_ordering_app/screens/splash_body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
        resizeToAvoidBottomInset: false,
    );
  }
}
