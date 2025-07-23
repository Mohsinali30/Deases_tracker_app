import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:polio_app/worldStates.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 4),
    vsync: this,
  )..repeat();
  // Animation controller

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Worldstates()),
        );
      });
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffFDFAF6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage('assets/cancer.png')),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),

           // SizedBox(height: MediaQuery.of(context).size.height * 0.11),

      /*  Center(
          child: SizedBox(
            width: 300.0,
            child:
            TextLiquidFill(
              text: 'Dease Tracker',
              waveColor: Color(0xff6FE6FC),
              boxBackgroundColor: Color(0xffFDFAF6),
              textStyle: const TextStyle(
                fontFamily: 'Canterbury',
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
              boxHeight: 300.0,
            ),
          ),
        ),


          const Align(
              alignment: Alignment.center,
              child: Text(
                " Polio ",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.white,fontStyle: FontStyle.normal, ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                " Tracker ",
                style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold,color: Colors.white,fontStyle: FontStyle.normal, ),
              ),
            ),
  */
          ],

        ),
      ),
    );
  }
}
