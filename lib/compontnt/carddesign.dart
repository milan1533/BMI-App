import 'package:flutter/material.dart';

class CardDesign extends StatelessWidget{

  final Widget child;

  const CardDesign({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context){


    return Card(
      shadowColor: Colors.yellow,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
       elevation: 5,

      child: Padding(padding: EdgeInsets.all(5),
        child: child,)
    );
  }
}