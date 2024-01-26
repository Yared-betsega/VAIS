import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  TranscriptionBloc() : super(TranscriptionInitial()) {
    on<Transcribe>((event, emit) {
      emit(TranscriptionLoading());

      Future.delayed(const Duration(seconds: 5), () {
        // The code inside this block will be executed after the delay
        if (kDebugMode) {
          print('Action completed after 5 seconds');
        }
      });

      emit(TranscriptionSuccess(questionAsText: "This is the question."));
    });
  }
}
