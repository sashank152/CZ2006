import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String time;
  final LatLng coordinates;
  final String location;

  const Place(
    this.time,
    this.coordinates,
    this.location,
  );
}
