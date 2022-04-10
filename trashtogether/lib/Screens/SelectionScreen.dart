import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/resources/LocationMethods.dart';
import 'package:trashtogether/utils/E-waste-data.dart';
import 'package:trashtogether/utils/cashfortrash.dart';
import 'package:trashtogether/utils/colors.dart';
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
  String dropdownValueOne = "Cash For Trash";
  String dropdownValueTwo = "Blk 108 Bukit Purmei";
  var locations = <String>[];
  List<Place> data = [];
  LocationMethods locationMethods = LocationMethods();

  void getLocations(List<Place> locationtype) async {
    locations = [];
    for (Place place in locationtype) {
      locations.add(place.location);
    }
    setState(() {
      data = locationtype;
    });
  }

  void changePlace() {
    for (Place place in data) {
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
    getLocations(cashForTrash);
  }

  Place getNearestPlace() {
    Place nearest = data[0];
    double minDist = 10000000000;
    for (Place place in data) {
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
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/registration.png"), fit: BoxFit.cover)),
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 270),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: containerColor),
        child: Column(
          children: [
            const Text("Select Type of bins/stations"),
            DropdownButton<String>(
              value: dropdownValueOne,
              icon: const Icon(Icons.arrow_downward_rounded,
                  color: webBackgroundColor),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              items: <String>['Cash For Trash', 'E-Waste']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueOne = newValue!;
                  if (newValue == "E-Waste") {
                    dropdownValueTwo = ewaste[0].location;
                    getLocations(ewaste);
                  } else if (newValue == "Cash For Trash") {
                    dropdownValueTwo = cashForTrash[0].location;
                    getLocations(cashForTrash);
                  }
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Select Location"),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValueTwo,
              icon:
                  Icon(Icons.arrow_downward_rounded, color: webBackgroundColor),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                      child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  )),
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
              style: ElevatedButton.styleFrom(primary: darkgreen),
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
              style: ElevatedButton.styleFrom(primary: darkgreen),
              onPressed: () {
                Place place = getNearestPlace();
                print(place.location);
              },
              child: Text("Select nearest location"),
            ),
          ],
        ),
      ),
    );
  }
}
