import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vais_mobile/features/transcription/presentation/bloc/transcription/transcription_bloc.dart';
import 'package:vais_mobile/features/transcription/presentation/pages/transcription_success_page.dart';
import 'package:vais_mobile/features/transcription/presentation/widgets/loading_indicator.dart';

import '../widgets/action_button.dart';
import '../widgets/custom_snack_bar.dart';

enum RecordingState { idle, recording, speaking }

enum PlayingState { idle, playing }

class TranscribePage extends StatefulWidget {
  const TranscribePage({super.key, required this.title});
  final String title;
  @override
  State<TranscribePage> createState() => _TranscribePageState();
}

class _TranscribePageState extends State<TranscribePage> {
  late FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  bool _play = false;
  int seconds = 0;
  late Timer timer;
  bool isTimerRunning = false;
  RecordingState recordingState = RecordingState.idle;
  PlayingState playingState = PlayingState.idle;

  void startRecorder() async {
    final tempDir = await Directory.systemTemp.createTemp();
    filePath = "${tempDir.path}/temp.wav";
    _myRecorder = FlutterSoundRecorder();
    await _myRecorder.openRecorder();

    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        seconds++;
      });
    });
    resetTimer();
  }

  void stopTimer() {
    timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    startRecorder();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatTime(seconds);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Center(child: Text('ቫይስ')),
      ),
      body: BlocConsumer<TranscriptionBloc, TranscriptionState>(
        listener: (context, state) {
          if (state is TranscriptionSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TranscriptionSuccessPage(
                          answerAudio: state.answerAudio,
                        )));
          } else if (state is TranscriptionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnackBarContent(errorText: state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(fontSize: 35.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    recordingState == RecordingState.recording
                        ? const ThreeBounceLoadingIndicator()
                        : ActionButton(
                            text: "መጠየቅ ጀምር",
                            icon: Icons.mic,
                            iconColor: Colors.red,
                            f: () {
                              record();
                              if (!isTimerRunning) {
                                startTimer();
                                setState(() {
                                  isTimerRunning = true;
                                });
                              }
                              setState(() {
                                recordingState = RecordingState.recording;
                              });
                            }),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<TranscriptionBloc, TranscriptionState>(
                      builder: (context, state) {
                        return state is TranscriptionLoading
                            ? const ThreeBounceLoadingIndicator()
                            : ActionButton(
                                text: "መጠየቅ ጨርስ",
                                icon: Icons.stop,
                                iconColor: Colors.black,
                                f: () {
                                  stopRecord();
                                  if (isTimerRunning) {
                                    stopTimer();
                                  }
                                  File audioFile = File(filePath);
                                  BlocProvider.of<TranscriptionBloc>(context)
                                      .add(Transcribe(audioFile));

                                  setState(() {
                                    recordingState = RecordingState.idle;
                                  });
                                });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    playingState == PlayingState.playing
                        ? const ThreeBounceLoadingIndicator()
                        : ActionButton(
                            text: "የጠየክሁትን አሰማኝ",
                            icon: Icons.play_arrow,
                            iconColor: Colors.black,
                            f: () {
                              startPlaying();
                              setState(() {
                                playingState = PlayingState.playing;
                              });
                            }),
                    const SizedBox(
                      height: 30,
                    ),
                    ActionButton(
                        text: "መጫወት አቁም",
                        icon: Icons.stop,
                        iconColor: Colors.black,
                        f: () {
                          stopPlaying();
                          setState(() {
                            playingState = PlayingState.idle;
                          });
                        }),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    return DateFormat('HH:mm:ss')
        .format(DateTime(0, 0, 0, 0, 0, 0, 0, 0).add(duration));
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }

    _myRecorder.openRecorder();
    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));

    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription recordSubscription =
        _myRecorder.onProgress!.listen((event) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          event.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat("mm:ss:SS", "en_GB").format(date);
      setState(() {});
    });

    recordSubscription.cancel();
  }

  Future<String?> stopRecord() async {
    _myRecorder.closeRecorder();
    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }

  @override
  void dispose() {
    _myRecorder.closeRecorder(); // Null-aware operation

    audioPlayer.stop();
    audioPlayer.dispose();
    timer.cancel();
    super.dispose();
  }
}
