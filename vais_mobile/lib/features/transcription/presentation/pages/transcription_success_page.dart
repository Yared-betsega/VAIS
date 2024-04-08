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
  bool isPaused = false;
  Duration? duration;
  Duration? position;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((d) => setState(() => duration = d));
    audioPlayer.onPositionChanged.listen((p) => setState(() => position = p));
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        setState(() {
          isPlaying = true;
          isPaused = false;
        });
      } else if (state == PlayerState.paused) {
        setState(() {
          isPlaying = false;
          isPaused = true;
        });
      } else {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });
    playPauseAudio(); // Start playing audio automatically
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playPauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(DeviceFileSource(widget.answerAudio.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 233, 212),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'ቫይስ',
            style: TextStyle(
                color: Colors.white), // White text for better contrast
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w), // Use ResponsiveSizer for padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // Container for the play button with some decoration
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: IconButton(
                  onPressed: playPauseAudio,
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (duration != null && position != null)
                Slider(
                  value: position!.inMilliseconds.toDouble(),
                  min: 0.0,
                  max: duration!.inMilliseconds.toDouble(),
                  onChanged: (double value) {
                    audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    setState(() {
                      position = Duration(milliseconds: value.toInt());
                    });
                  },
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey[400],
                ),
              const SizedBox(height: 20),
              // if (isPlaying || isPaused)
              //   const ThreeBounceLoadingIndicator() // Loading widget
              // else
              //   Text(
              //     'Audio file path: ${widget.answerAudio.path}',
              //     style: TextStyle(
              //       fontSize: 16.sp,
              //       color: Colors.black54,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
