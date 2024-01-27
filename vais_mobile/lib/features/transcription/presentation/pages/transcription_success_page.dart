import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TranscriptionSuccessPage extends StatelessWidget {
  final String questionAsText;
  const TranscriptionSuccessPage({super.key, required this.questionAsText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Center(child: Text('ቫይስ')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Center(
          child: Text(
            questionAsText,
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}
