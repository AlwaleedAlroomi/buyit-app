import 'package:buyit/constants.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  static String id = "HomepPageScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: Image(image:AssetImage("assets/images/jackets/jacket2.jpg")),
      ),
    );
  }
}
