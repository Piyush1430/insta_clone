import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:insta_clone/features/presentation/pages/home/home_screen.dart";
import "package:insta_clone/features/presentation/pages/profile/profile_page.dart";
import "package:insta_clone/utils/colors.dart";
import "package:flutter_icons_null_safety/flutter_icons_null_safety.dart";
import "package:insta_clone/utils/global_variables.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.uid});
  final String uid;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateToPage(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: screenSize.width < webScreenSize
            ? mobileBackgroundColor
            : webBackgroundColor,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                MaterialCommunityIcons.home_variant,
                color: primaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
                color: primaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.md_add_circle_outline,
                color: primaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: primaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: primaryColor),
              label: ""),
        ],
        onTap: navigateToPage,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChange,
        children: const [
          HomeScreen(),
          Center(
            child: Text(
              "SearchScreen",
              style: TextStyle(color: primaryColor),
            ),
          ),
          Center(
            child: Text(
              "Post Screen",
              style: TextStyle(color: primaryColor),
            ),
          ),
          Center(
            child: Text(
              "Favorite Screen",
              style: TextStyle(color: primaryColor),
            ),
          ),
          ProfilePage(),
        ],
      ),
    );
  }
}
