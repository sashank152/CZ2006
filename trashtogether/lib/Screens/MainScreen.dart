import 'package:flutter/material.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/utils/data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  late PageController pageController;
  void changePage(int page) {
    setState(() => _page = page);
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: mobileBackgroundColor,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: changePage,
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.add_location_rounded,
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
