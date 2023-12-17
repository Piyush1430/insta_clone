import "package:flutter/material.dart";
import "package:flutter_icons_null_safety/flutter_icons_null_safety.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:insta_clone/utils/colors.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/ic_instagram.svg",
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          height: screenSize.height*0.036,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenSize.width * 0.01),
            child: const Icon(
              MaterialCommunityIcons.facebook_messenger,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
