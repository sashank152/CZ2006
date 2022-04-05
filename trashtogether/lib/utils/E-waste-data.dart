import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/models/Place.dart';

Future<String> getJSON() {
  return rootBundle.loadString('images/E-waste-location-data.json');
}

List<Place> ewaste = [];
var data = [];
initEData() async {
  var EwasteData = jsonDecode(await getJSON());
  data = EwasteData['data'];
  for (var location in data) {
    ewaste.add(Place(
        LatLng(location['coordinates'][1], location['coordinates'][0]),
        location['location']));
  }
}
