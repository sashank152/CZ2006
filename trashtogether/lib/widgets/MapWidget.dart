import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/resources/LocationMethods.dart';
import 'package:trashtogether/utils/data.dart';

class MapWidget extends StatefulWidget {
  Position currentPosition;
  final Place place;
  MapWidget({Key? key, required this.currentPosition, required this.place})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late LocationPermission permission;
  late GoogleMapController mapController;
  late LatLng _destination;
  late Marker destinationMarker;
  Set<Marker> markers = {};
  LocationMethods LM = new LocationMethods();

  late PolylinePoints polylinePoints;
  var polylines = <PolylineId, Polyline>{};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _destination = widget.place.coordinates;
    destinationMarker = Marker(
        markerId: MarkerId(widget.place.location), position: _destination);
    markers.add(destinationMarker);
    _createPolyLines();
  }

  double calculateDistance() {
    return Geolocator.distanceBetween(
        widget.currentPosition.latitude,
        widget.currentPosition.longitude,
        _destination.longitude,
        _destination.latitude);
  }

  _createPolyLines() async {
    print(markers);
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_API_KEY']!, // Google Maps API Key
      PointLatLng(
          widget.currentPosition.latitude, widget.currentPosition.longitude),
      PointLatLng(_destination.latitude, _destination.longitude),
      travelMode: TravelMode.transit,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.currentPosition.latitude,
                widget.currentPosition.longitude),
            zoom: 12),
        myLocationEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }
}
