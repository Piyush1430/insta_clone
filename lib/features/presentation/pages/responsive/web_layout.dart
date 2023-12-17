import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: webBackgroundColor,
      body: Center(
        child: Text("Web layout"),
      ),
    );
  }
}
