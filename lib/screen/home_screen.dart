import 'package:flutter/material.dart';

import '../compontnt/inputfielddesign.dart';
import 'bmiscreen.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  var nameController = TextEditingController();



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            inputDeisgn(
              controller: nameController,
              label: "Enter Your Name",
              prefixIcon: Icons.person,
              keyboardType: TextInputType.text,
            ),

            SizedBox(height: 20,),

            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) => BMIScreen(nameForHome:
               nameController.text,)
               ),
              );
            }, child:Text(" Done"))
          ],
        ),
      ),
    );
  }
}