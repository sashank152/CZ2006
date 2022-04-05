import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/models/Place.dart';

Future<String> getJSON() {
  return rootBundle.loadString('images/trashforcashlocations.json');
}

List<Place> cashForTrash = [];
var data = [];
initCashData() async {
  var temp = jsonDecode(await getJSON());
  data = temp.keys.toList();
  var locs;
  for (var item in data) {
    locs = await getLocations(item);
    cashForTrash.add(Place(LatLng(locs[0].latitude, locs[0].longitude), item));
  }
}

Future<List<Location>> getLocations(String str) async {
  return await locationFromAddress(str);
}
