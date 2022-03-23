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
  double sum = 0;

  @override
  void dispose() {
    super.dispose();
    newspaperController.dispose();
    cartonController.dispose();
    otherPaperController.dispose();
  }

  void calculate() {
    setState(() {
      sum = (double.parse(newspaperController.text)) *
              rates["newspaper"]!.toDouble() +
          (double.parse(cartonController.text)) * rates["carton"]!.toDouble() +
          (double.parse(otherPaperController.text)) *
              rates["other papers"]!.toDouble() +
          (double.parse(aluminiumCanController.text)) *
              rates["aluminium cans"]!.toDouble() +
          (double.parse(foodTinController.text)) *
              rates["food tins"]!.toDouble() +
          (double.parse(clothingController.text)) *
              rates["reusable clothing"]!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("Calculate your cash from your trash"),
            Text("Newspaper"),
            TextInputField(
                hintText: "Weight in Kgs",
                controller: newspaperController,
                inputType: TextInputType.number),
            Text("Cartons"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: cartonController,
                inputType: TextInputType.number),
            Text("Other Papers"),
            TextInputField(
                hintText: "Weight in kgs",
                controller: otherPaperController,
                inputType: TextInputType.number),
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
