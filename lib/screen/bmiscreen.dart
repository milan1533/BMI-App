import 'package:flutter/material.dart';
import '../compontnt/carddesign.dart';
import '../compontnt/inputfielddesign.dart';

class BMIScreen extends StatefulWidget {

  final String nameForHome;

  const BMIScreen({
    super.key,
    required this.nameForHome,
  }
      );



  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  var inchController = TextEditingController();
  var ftController = TextEditingController();
  var wtController = TextEditingController();


  String result = "";
  String status = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            "Calculate Your BMI, ${widget.nameForHome}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: 350,
            child: CardDesign(
              child: inputDeisgn(
                controller: inchController,
                label: "Enter Height in Inch",
                prefixIcon: Icons.height,
                keyboardType: TextInputType.number,
              ),
            ),
          ),

          SizedBox(
            width: 350,
            child: CardDesign(
              child: inputDeisgn(
                controller: ftController,
                label: "Enter Height in Feet",
                prefixIcon: Icons.height,
                keyboardType: TextInputType.number,
              ),
            ),
          ),

          SizedBox(
            width: 350,
            child: CardDesign(
              child: inputDeisgn(
                controller: wtController,
                label: "Enter Weight in KG",
                prefixIcon: Icons.line_weight,
                keyboardType: TextInputType.number,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(

                onPressed: () {

                  var inch = inchController.text.trim();
                  var ft = ftController.text.trim();
                  var wt = wtController.text.trim();

                  if (
                  inch.isNotEmpty &&
                      ft.isNotEmpty &&
                      wt.isNotEmpty
                  ) {

                    var iInch = double.parse(inch);
                    var iFt = double.parse(ft);
                    var iWt = double.parse(wt);

                    var totalInch =
                        (iFt * 12) + iInch;

                    var totalCm =
                        totalInch * 2.54;

                    var totalM =
                        totalCm / 100;

                    double bmi =
                        iWt / (totalM * totalM);

                    String health;

                    if (bmi < 18.5) {
                      health = "Underweight";
                    }
                    else if (bmi < 25) {
                      health =
                      "Healthy / Perfect Body";
                    }
                    else if (bmi < 30) {
                      health = "Overweight";
                    }
                    else {
                      health = "Obese";
                    }

                    setState(() {
                      result =
                          bmi.toStringAsFixed(2);

                      status = health;
                    });

                  } else {

                    setState(() {

                      result = "";

                      status =
                      "Fill All Fields";

                    });

                  }

                },

                child: const Text(
                  "Calculate",
                ),

              ),

              const SizedBox(
                width: 15,
              ),

              ElevatedButton(

                onPressed: () {

                  inchController.clear();

                  ftController.clear();

                  wtController.clear();

                  setState(() {

                    result = "";

                    status = "";

                  });

                },

                child: const Text(
                  "Reset",
                ),

              ),

            ],
          ),

          const SizedBox(height: 25),

          if (result.isNotEmpty)

            Text(

              "Your BMI is $result",

              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),

            ),

          const SizedBox(height: 10),

          Text(

            status,

            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontWeight:
              FontWeight.bold,
            ),

          ),

          SizedBox(height: 20,),



        ],
      ),
    );
  }
}