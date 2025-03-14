import 'dart:async';
import 'package:apt/onboarding/startpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartPage()));
    });
  }

  void startpage() async {
    print('1초');
    await Future.delayed(const Duration(seconds: 1));
    print('2초');
    await Future.delayed(const Duration(seconds: 1));
    print('3초');
    await Future.delayed(const Duration(seconds: 1));
    print('시작!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center( child:
      Image.asset('asset/images/splash.png'),
    ),);
  }
}
