import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/Screens/Calculator.dart';
import 'package:trashtogether/Screens/SelectionScreen.dart';
import 'package:trashtogether/widgets/Map.dart';

const locations = {
  "Blk 108 Bukit Purmei": " Last Sunday of every odd month 9am to 12pm ",
  "Blk 114 Bukit Purmei @ Void deck":
      "1st and 3rd Sunday of the month 8am to 1pm"
};

const rates = {
  "newspaper": 0.15,
  "carton": 0.15,
  "other papers": 0.1,
  "aluminium cans": 0.8,
  "food tins": 0.25,
  "reusable clothing": 0.25
};

const pages = [ SelectionScreen(), Map(), CalculatorScreen()];

const sgPosition =
    CameraPosition(target: LatLng(1.290270, 103.851959), zoom: 15);
