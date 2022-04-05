import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashtogether/Screens/Calculator.dart';
import 'package:trashtogether/Screens/ProfileScreen.dart';
import 'package:trashtogether/Screens/SelectionScreen.dart';
import 'package:trashtogether/models/Place.dart';
import 'package:trashtogether/utils/cashfortrash.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/utils/data.dart';
import 'package:trashtogether/widgets/MapWidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Place selectedPlace = places[0];
  bool isLoading = true;
  late Position currentPosition;
  int _page = 0;
  late PageController pageController;
  LocationPermission permission = LocationPermission.unableToDetermine;
  void changePage(int page) {
    setState(() => _page = page);
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onNearestChanged(Place place) {
    setState(() {
      selectedPlace = place;
    });
  }

  void getPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        setState(() {
          //isLoading = false;
          _getCurrentLocation();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
    pageController = PageController();
    _getCurrentLocation();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        currentPosition = position;
        isLoading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever)
                ? Text('Please restart app and enable location permissions')
                : const CircularProgressIndicator(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen())),
                ),
              ],
              title: Text(_page == 0
                  ? "Select Location"
                  : _page == 1
                      ? "Map"
                      : "Calculator"),
              centerTitle: true,
              backgroundColor: fieldColor,
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: changePage,
              controller: pageController,
              children: [
                SelectionScreen(
                  onPlaceSelected: onNearestChanged,
                  currentPosition: currentPosition,
                  pageController: pageController,
                ),
                MapWidget(
                  place: selectedPlace,
                  currentPosition: currentPosition,
                ),
                const CalculatorScreen()
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: BottomNavigationBar(
                backgroundColor: fieldColor,
                items: [
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.filter_list_rounded,
                        color: _page == 0 ? Colors.white : Colors.black,
                      ),
                      backgroundColor: fieldColor),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.add_location_rounded,
                        color: _page == 1 ? Colors.white : Colors.black,
                      ),
                      backgroundColor: fieldColor),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.calculate_rounded,
                        color: _page == 2 ? Colors.white : Colors.black,
                      ),
                      backgroundColor: fieldColor)
                ],
                onTap: navigationTapped,
              ),
            ),
          );
  }
}
