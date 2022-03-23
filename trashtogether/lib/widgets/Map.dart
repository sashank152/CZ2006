import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/utils/data.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng currentLatLng = const LatLng(0, 0);
  late LocationPermission permission;
  late Position currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosition();
    print("test2");
  }

  void getPosition() async {
    print("test1");

    currentPosition = await getPermission();
  }

  Future<Position> getPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        getLocation();
        return await Geolocator.getCurrentPosition();
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getLocation() async {
    print("yest");
    await Geolocator.getCurrentPosition().then((Position position) => {
          setState(() {
            currentLatLng = LatLng(position.latitude, position.longitude);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return currentLatLng == const LatLng(0, 0)
        ? const Center(child: CircularProgressIndicator())
        : Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: GoogleMap(
              initialCameraPosition: sgPosition,
              myLocationEnabled: true,
            ),
          );
  }
}
