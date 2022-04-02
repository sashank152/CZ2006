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
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    //const Text("Newspaper"),
                    Expanded(
                      flex: 1,
                      child: TextInputField(
                          hintText: "Weight in Kgs",
                          controller: newspaperController,
                          inputType: TextInputType.number),
                    ),
                  ],
                ),
              ),
              // const Text("Food tins"),*
              // Flexible(
              //   child: TextInputField(
              //       hintText: "Weight in kgs",
              //       controller: foodTinController,
              //       inputType: TextInputType.number),
              // ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          // Row(
          //   children: [
          //     const Text("Cartons"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: cartonController,
          //         inputType: TextInputType.number),
          //     const SizedBox(
          //       height: 30,
          //     ),
          //     const Text("Other Papers"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: otherPaperController,
          //         inputType: TextInputType.number),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     const Text("Aluminium cans"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: aluminiumCanController,
          //         inputType: TextInputType.number),
          //     const Text("PET & HDPE Bottles"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: hdpeBottleController,
          //         inputType: TextInputType.number),
          //   ],
          // ),
          // Row(
          //   children: [
          //     const Text("Glass bottles"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: glassController,
          //         inputType: TextInputType.number),
          //     const Text("Reusable Clothing"),
          //     TextInputField(
          //         hintText: "Weight in kgs",
          //         controller: clothingController,
          //         inputType: TextInputType.number),
          //   ],
          // ),
          // ElevatedButton(
          //     onPressed: calculate, child: const Text("Calculate Sum")),
          // Text(sum.toString())
        ],
      ),
    );
  }
}
