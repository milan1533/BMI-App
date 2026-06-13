
import 'dart:async';

import 'package:bmiapp/screen/bmiscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
       Timer(Duration(seconds: 3), (){
         Navigator.pushReplacement(
           context,
            MaterialPageRoute(builder: (cotext) => BMIScreen(),
         ),
         );
       }
       );

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade100,
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: Offset(0, 8),
                  ),
                ],
              ),

              child: Image.asset(
                "assets/images/bmi_logo.png",
                width: 180,
              ),
            )

          ],
        ),
      ),
    );
  }
}