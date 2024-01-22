import 'dart:async';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 1)
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut
    );
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() { _visible = !_visible; });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Where Quality Service is a Commitment.", 
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans'
                  )
                )
              )
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash.png',
                width: animation.value * 200,
                height: animation.value * 200
              )
            ]
          )
        ]
      )
    );
  }

  Future<Timer> startTime() async {
    return Timer(const Duration(seconds: 3), () async {
      await Navigator.of(context).pushAndRemoveUntil(App.route(), (route) => false);
      if (!mounted) return;
    });
  }
}