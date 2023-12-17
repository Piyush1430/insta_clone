import "package:flutter/material.dart";
import "package:insta_clone/utils/global_variables.dart";

class ResponsiveLayouts extends StatefulWidget {
  const ResponsiveLayouts(
      {super.key, required this.webLayout, required this.mobilelayout});
  final Widget webLayout;
  final Widget mobilelayout;

  @override
  State<ResponsiveLayouts> createState() => _ResponsiveLayoutsState();
}

class _ResponsiveLayoutsState extends State<ResponsiveLayouts> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webLayout;
        }
        return widget.mobilelayout;
      },
    );
  }
}
