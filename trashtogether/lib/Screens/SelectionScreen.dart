import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/resources/LocationMethods.dart';
import 'package:trashtogether/utils/data.dart';

class SelectionScreen extends StatefulWidget {
  final PageController pageController;
  final Function(Place) onPlaceSelected;
  Position currentPosition;
  SelectionScreen(
      {Key? key,
      required this.pageController,
      required this.currentPosition,
      required this.onPlaceSelected})
      : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String dropdownValueOne = "Recycle Bins";
  String dropdownValueTwo = "Blk 108 Bukit Purmei";
  var locations = <String>[];
  LocationMethods locationMethods = LocationMethods();

  void getLocations() async {
    for (var place in places) {
      locations.add(place.location);
    }
  }

  void changePlace() {
    for (Place place in places) {
      if (place.location == dropdownValueTwo) {
        widget.onPlaceSelected(place);
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocations();
  }

  Place getNearestPlace() {
    Place nearest = places[0];
    double minDist = 10000000000;
    for (Place place in places) {
      double tempDist = locationMethods.calculateDistance(
          widget.currentPosition.latitude,
          widget.currentPosition.longitude,
          place.coordinates.latitude,
          place.coordinates.longitude);
      if (minDist > tempDist) {
        minDist = tempDist;
        nearest = place;
      }
    }
    setState(() {
      dropdownValueTwo = nearest.location;
    });
    return nearest;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Select Type of bins/stations"),
          DropdownButton<String>(
            value: dropdownValueOne,
            icon: Icon(Icons.arrow_downward_rounded),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: <String>['Recycle Bins', 'Cash For Trash', 'E-Waste']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
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
            value: dropdownValueTwo,
            icon: Icon(Icons.arrow_downward_rounded),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: locations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
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
            onPressed: () {
              changePlace();
              widget.pageController.jumpToPage(1);
            },
            child: Text("Select"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Place place = getNearestPlace();
              print(place.location);
            },
            child: Text("Select nearest location"),
          ),
        ],
      ),
    );
  }
}
