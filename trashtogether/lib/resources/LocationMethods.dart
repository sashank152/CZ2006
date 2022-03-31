import 'package:geolocator/geolocator.dart';

class LocationMethods {
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      return position;
    }).catchError((e) {
      print(e);
    });
  }

  double calculateDistance(
      double curlat, double curlong, double destlat, double destlong) {
    return Geolocator.distanceBetween(curlat, curlong, destlong, destlat);
  }
}
