import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashtogether/Screens/Calculator.dart';
import 'package:trashtogether/Screens/ProfileScreen.dart';
import 'package:trashtogether/Screens/SelectionScreen.dart';
import 'package:trashtogether/models/Place.dart';
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

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _getCurrentLocation();
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
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen())),
                ),
              ],
              title: const Text("Home"),
              centerTitle: true,
              backgroundColor: mobileBackgroundColor,
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
                items: [
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.filter_list_rounded,
                        color: _page == 0 ? Colors.white : Colors.grey,
                      ),
                      backgroundColor: mobileBackgroundColor),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.add_location_rounded,
                        color: _page == 1 ? Colors.white : Colors.grey,
                      ),
                      backgroundColor: mobileBackgroundColor),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Icon(
                        Icons.calculate_rounded,
                        color: _page == 2 ? Colors.white : Colors.grey,
                      ),
                      backgroundColor: mobileBackgroundColor)
                ],
                onTap: navigationTapped,
              ),
            ),
          );
  }
}
