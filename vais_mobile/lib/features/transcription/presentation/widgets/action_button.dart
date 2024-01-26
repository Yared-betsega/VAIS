import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.f,
  });

  final IconData? icon;
  final Color? iconColor;
  final Function? f;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 7.h,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(5),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10.0),
            onPressed: () {
              f!();
            },
            icon: Icon(
              icon,
              color: iconColor,
            ),
            label: Text(
              text,
              style: TextStyle(fontSize: 17.sp),
            )),
      ),
    );
  }
}
