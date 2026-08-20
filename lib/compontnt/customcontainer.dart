import 'package:flutter/material.dart';

class Customcontainer extends StatelessWidget{

  final Color color;
  final double width;
  final double height;
  final Widget child;


  const Customcontainer({
    super.key,
    this.color = Colors.white,
    this.width = double.infinity,
     this.height = double.infinity,
    required this.child,
  });

  @override
  Widget build(BuildContext cotext){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
           Color(0xffFFF1EB),
            Color(0xffACE0F9),
        ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}