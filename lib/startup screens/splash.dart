import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.popAndPushNamed(context, "chooseanguage");
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child:
      SvgPicture.asset("assets/tamweeli_logo 1.svg"),
    )
    );
  }
}
