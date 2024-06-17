import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ThreeBounceLoadingIndicator extends StatelessWidget {
  double elevation;
  ThreeBounceLoadingIndicator({super.key, required this.elevation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 7.h,
      child: Material(
          elevation: elevation,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: const Color.fromARGB(255, 212, 233, 212),
                shape: BoxShape.rectangle),
            child: const SpinKitThreeBounce(
              color: Colors.green,
              size: 50.0,
            ),
          )),
    );
  }
}
