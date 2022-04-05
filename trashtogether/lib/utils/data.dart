import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/utils/E-waste-data.dart';
import 'package:trashtogether/utils/cashfortrash.dart';

const locations = {
  'Blk 108 Bukit Purmei': 'Last Sunday of every odd month 9am to 12pm',
  'Blk 114 Bukit Purmei @ Void deck':
      '1st and 3rd Sunday of the month (from 20 Feb) 8am to 1pm',
  'Blk 462 Crawford Lane Fitness Corner':
      '1st Sunday of the month 10am to 12pm',
  'Blk 133 Clarence Lane, S140133': '2nd Sunday of Feb, Apr, Jun 9am to 12pm',
  'Blk 61 Strathmore Avenue, S141061 (Beside Delta RC Center)':
      '2nd Sunday of Jan, Mar, May 9am to 12pm',
  'Blk 95A Henderson Rd, S15109': '1st Sunday of the month 9am to 12pm',
  'Blk 535 Upper Cross Street, in front of Fook Hai Building':
      '3rd Sunday of the month 9am to 12pm',
  'Blk 22 Boon Keng Road #01-11, S(330022)':
      '3rd Saturday of the month 9am to 1pm',
  'Blk 6 (Void Deck) Boon Keng Rd, S330006':
      '2nd Sunday of the month 10am to 12pm',
  'Cheng Yan Court, Blk 269 Queen St, S180269':
      '2nd Saturday of the month 9am to 12pm',
  'Blk 82B Circuit Road': '4th Saturday of the month 9am to 12pm',
  'Blk 5 Pine Close, S391005': '1st Monday of the month 9am to 1pm',
  'Blk 84A Redhill Lane, S150084, @ Multi-purpose Hall':
      'Last Sunday of the month 9am to 12pm',
  'Blk 104 Spottiswoode Park Rd, Void Deck':
      '2nd Sunday of the month 10am to 12.30pm',
  'Blk 105 Jalan Rajah RC Centre, S320105':
      'Last Saturday of odd months 2pm to 4pm'
};

const places = [
  Place(LatLng(1.273645296597597, 103.82547679727492), "Blk 108 Bukit Purmei"),
  Place(LatLng(1.2754621535241069, 103.82581883942177),
      "Blk 114 Bukit Purmei @ Void deck"),
];

const rates = <double>[0.15, 0.15, 0.1, 0.8, 0.25, 0.0, 0.0, 0.25];

//const pages = [SelectionScreen(), Map(), CalculatorScreen()];

const sgPosition =
    CameraPosition(target: LatLng(1.290270, 103.851959), zoom: 15);

void initData() {
  initEData();
  initCashData();
}
