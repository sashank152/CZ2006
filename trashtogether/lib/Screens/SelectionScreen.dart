import 'package:flutter/material.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String dropdownValueOne = "test";
  String dropdownValueTwo = "test Location";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Select Type of bins/stations"),
          DropdownButton<String>(
            icon: Icon(Icons.arrow_downward_rounded),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValueOne = newValue!;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text("Select Location"),
          DropdownButton<String>(
            icon: Icon(Icons.arrow_downward_rounded),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: <String>[
              'Location One',
              'Location Two',
              'Location Free',
              'Location Four'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValueTwo = newValue!;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            onPressed: () {},
            child: Text("Select"),
          ),
        ],
      ),
    );
  }
}
