import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackBarContent extends StatelessWidget {
  final String errorText;
  const CustomSnackBarContent({Key? key, required this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ማሳወቂያ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      errorText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/bubbles.svg',
                  height: 48,
                  width: 40,
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: -14,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/fail.svg',
                  height: 40,
                ),
              ],
            ))
      ],
    );
  }
}
