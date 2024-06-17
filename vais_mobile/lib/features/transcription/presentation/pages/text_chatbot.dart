import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/question/transcription_bloc.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/loading_indicator.dart';
import 'transcription_success_page.dart';

class TextChatbotPage extends StatefulWidget {
  const TextChatbotPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TextChatbotPage> createState() => _TextChatbotPageState();
}

class _TextChatbotPageState extends State<TextChatbotPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 233, 212),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: BlocBuilder<TranscriptionBloc, TranscriptionState>(
                    builder: (context, state) {
                      return state is TranscriptionLoading
                          ? ThreeBounceLoadingIndicator(
                              elevation: 0.0,
                            )
                          : const Text("");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines:
                            null, // Allows the input field to expand as more lines are added
                        decoration: InputDecoration(
                          hintText: 'እባክዎ ጥያቄዎን ይጥይቁ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _sendMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                        foregroundColor: Colors.white, // Text color
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _sendMessage() {
    BlocProvider.of<TranscriptionBloc>(context)
        .add(AskTextQuestion(question: _controller.text));
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }
}
