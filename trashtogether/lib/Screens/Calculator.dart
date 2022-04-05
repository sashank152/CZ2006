import 'package:flutter/material.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/utils/data.dart';
import 'package:trashtogether/widgets/TextInputField.dart';
import 'package:trashtogether/widgets/NumInputField.dart';

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
          prices.add(double.parse(tec.text).abs() * rates[i]);
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
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .05,
          MediaQuery.of(context).size.height * .05,
          MediaQuery.of(context).size.width * .05,
          MediaQuery.of(context).size.height * .15),
      child: Column(
        children: [
          const Text(
            'Calculate your Cash from your Trash',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                  color: inputColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Newspaper',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: newspaperController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Food Tins',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: foodTinController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text(
                                  'Cartons',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: cartonController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Aluminium Cans',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: aluminiumCanController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Glass Bottles',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: glassController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Reusable Clothing',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: clothingController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('Other Paper',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: otherPaperController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                            child: Column(
                              children: [
                                const Text('HDPE Bottles',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: NumInputField(
                                      hintText: "Weight in Kgs",
                                      controller: hdpeBottleController,
                                      inputType: TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: calculate,
                    child: const Text("Calculate",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(primary: darkgreen),
                  ),
                  Text(
                    sum.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
