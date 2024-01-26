import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ThreeBounceLoadingIndicator extends StatelessWidget {
  const ThreeBounceLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 7.h,
      child: Material(
          elevation: 10.0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.rectangle),
            child: const SpinKitThreeBounce(
              color: Colors.green,
              size: 50.0,
            ),
          )),
    );
  }
}
