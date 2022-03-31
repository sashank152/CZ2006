import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/Screens/Calculator.dart';
import 'package:trashtogether/Screens/SelectionScreen.dart';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/widgets/MapWidget.dart';

const locations = {
  "Blk 108 Bukit Purmei": "Last Sunday of every odd month 9am to 12pm",
  "Blk 114 Bukit Purmei @ Void deck":
      "1st and 3rd Sunday of the month 8am to 1pm"
};

const places = [
  Place("Last Sunday of every odd month 9am to 12pm",
      LatLng(1.273645296597597, 103.82547679727492), "Blk 108 Bukit Purmei"),
  Place(
      "1st and 3rd Sunday of the month 8am to 1pm",
      LatLng(1.2754621535241069, 103.82581883942177),
      "Blk 114 Bukit Purmei @ Void deck"),
];

const rates = <double>[0.15, 0.15, 0.1, 0.8, 0.25, 0.0, 0.0, 0, 25];

//const pages = [SelectionScreen(), Map(), CalculatorScreen()];

const sgPosition =
    CameraPosition(target: LatLng(1.290270, 103.851959), zoom: 15);
