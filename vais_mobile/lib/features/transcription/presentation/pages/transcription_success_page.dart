import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vais_mobile/features/transcription/presentation/pages/transcribe.dart';
import 'package:vais_mobile/features/transcription/presentation/widgets/loading_indicator.dart';

class TranscriptionSuccessPage extends StatefulWidget {
  final File answerAudio;

  const TranscriptionSuccessPage({Key? key, required this.answerAudio})
      : super(key: key);

  @override
  _TranscriptionSuccessPageState createState() =>
      _TranscriptionSuccessPageState();
}

class _TranscriptionSuccessPageState extends State<TranscriptionSuccessPage> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayingState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    await audioPlayer.play(DeviceFileSource(widget.answerAudio.path));
    ;
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  playAudio();
                  setState(() {
                    isPlaying = true;
                  });
                },
                child: Text('መልስ'),
              ),
              SizedBox(height: 20),
              if (isPlaying)
                const ThreeBounceLoadingIndicator() // Loading widget
              else
                Text(
                  'Audio file path: ${widget.answerAudio.path}',
                  style: TextStyle(fontSize: 18.sp),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
