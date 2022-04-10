import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final LatLng coordinates;
  final String location;

  const Place(
    this.coordinates,
    this.location,
  );
}
