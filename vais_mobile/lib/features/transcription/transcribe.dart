import 'package:flutter/material.dart';

class Transcribe extends StatefulWidget {
  const Transcribe({super.key, required this.title});
  final String title;
  @override
  State<Transcribe> createState() => _TranscribeState();
}

class _TranscribeState extends State<Transcribe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Transcribe"),
          ),
        ],
      ),
    );
  }
}
