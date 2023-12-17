import "package:flutter/material.dart";
import "package:insta_clone/utils/colors.dart";

class ButtonConatinerWidget extends StatelessWidget {
  const ButtonConatinerWidget(
      {super.key,
      this.color,
      this.buttonName,
      required this.onTapListener,
      this.outLineButton});
  final Color? color;
  final String? buttonName;
  final bool? outLineButton;
  final void Function() onTapListener;
  @override
  Widget build(BuildContext context) {
    return outLineButton == true
        ? OutlinedButton(
            onPressed: onTapListener,
            style: OutlinedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 2,
                minimumSize: const Size(double.infinity, 40),
                foregroundColor: color,
                side: BorderSide(color: color!)),
            child: Text(
              "$buttonName",
              style: const TextStyle(
                  color: blueColor, fontWeight: FontWeight.w600),
            ),
          )
        : ElevatedButton(
            onPressed: onTapListener,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: Text(
              "$buttonName",
              style: const TextStyle(
                  color: primaryColor, fontWeight: FontWeight.w600),
            ),
          );
  }
}
