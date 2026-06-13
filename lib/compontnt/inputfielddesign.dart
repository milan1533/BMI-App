import 'package:flutter/material.dart';

class inputDeisgn extends StatelessWidget{

  final TextEditingController controller;
  final String label;
  final IconData ? prefixIcon;
  final TextInputType keyboardType;

  const inputDeisgn(
  {
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.keyboardType = TextInputType.number,

   });

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.green.shade100),
        ),
      ),
    );
  }
}