import 'dart:async';

import 'package:dod/plugin/global/global.dart';
import 'package:dod/theme/color.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation scale;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    scale = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc));
    controller.forward();

    controller.addListener((){
      if(controller.isCompleted){
       Timer(Duration(seconds: 1),(){
         statusPage.sink.add(true);
       });
        
      }
    });

    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      color: azul,
      child: Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, snapshot) {
              return Transform.scale(
                  scale: scale.value,
                  child: SizedBox(
                    height: 200.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset("assets/images/logo.png"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "O analytics da internet no mundo físico!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height*0.03,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    ));
  }
}
