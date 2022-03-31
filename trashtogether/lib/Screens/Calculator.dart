import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trashtogether/utils/data.dart';
import 'package:trashtogether/widgets/TextInputField.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController newspaperController = TextEditingController();
  TextEditingController cartonController = TextEditingController();
  TextEditingController otherPaperController = TextEditingController();
  TextEditingController aluminiumCanController = TextEditingController();
  TextEditingController foodTinController = TextEditingController();
  TextEditingController hdpeBottleController = TextEditingController();
  TextEditingController glassController = TextEditingController();
  TextEditingController clothingController = TextEditingController();
  List<TextEditingController> controllerList = [];
  double sum = 0;

  @override
  void dispose() {
    super.dispose();
    newspaperController.dispose();
    cartonController.dispose();
    otherPaperController.dispose();
  }

  @override
  void initState() {
    super.initState();
    controllerList = [
      newspaperController,
      cartonController,
      otherPaperController,
      aluminiumCanController,
      foodTinController,
      hdpeBottleController,
      glassController,
      clothingController
    ];
  }

  void calculate() {
    setState(() {
      sum = 0;
    });
    var prices = <double>[];
    for (int i = 0; i < controllerList.length; i++) {
      TextEditingController tec = controllerList[i];
      if (tec.text.isNotEmpty) {
        try {
          prices.add(double.parse(tec.text) * rates[i]);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
          print(e);
        }
      }
    }
    setState(() {
      for (double price in prices) {
        sum = sum + price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("Calculate your cash from your trash",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue.shade200)),
            SizedBox(
              height: 60,
            ),
            Text("Newspaper"),
            TextInputField(
                hintText: "Weight in Kgs",
                controller: newspaperController,
                inputType: TextInputType.number),
            SizedBox(
              height: 30,
            ),
            Text("Cartons"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: cartonController,
                inputType: TextInputType.number),
            SizedBox(
              height: 30,
            ),
            Text("Other Papers"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: otherPaperController,
                inputType: TextInputType.number),
            SizedBox(
              height: 30,
            ),
            Text("Aluminium cans"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: aluminiumCanController,
                inputType: TextInputType.number),
            Text("Food tins"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: foodTinController,
                inputType: TextInputType.number),
            Text("PET & HDPE Bottles"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: hdpeBottleController,
                inputType: TextInputType.number),
            Text("Glass bottles"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: glassController,
                inputType: TextInputType.number),
            Text("Reusable Clothing"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: clothingController,
                inputType: TextInputType.number),
            ElevatedButton(onPressed: calculate, child: Text("Calculate Sum")),
            Text(sum.toString())
          ],
        ),
      ),
    );
  }
}
