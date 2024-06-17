import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/audio_question.dart';
import 'package:vais_mobile/features/transcription/domain/entities/text_question.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/audio_question_usecase.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/text_question_usecase.dart';

import '../../../../../core/errors/failures.dart';

part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  final AskAudioQuestionUseCase askAudioQuestionUseCase;
  final AskTextQuestionUseCase askTextQuestionUseCase;

  TranscriptionBloc(
      {required this.askAudioQuestionUseCase,
      required this.askTextQuestionUseCase})
      : super(TranscriptionInitial()) {
    on<AskAudioQuestion>((event, emit) async {
      emit(TranscriptionLoading());

      await Future<dynamic>.delayed(const Duration(seconds: 2));

      final AudioQuestion question =
          AudioQuestion(questionFile: event.question);
      final Either<Failure, Answer> response =
          await askAudioQuestionUseCase(question);

      response.fold(
          (Failure failure) =>
              emit(TranscriptionFailure(message: failure.message)),
          (Answer answer) =>
              emit(TranscriptionSuccess(answerAudio: answer.answerAudio)));
    });

    on<AskTextQuestion>((event, emit) async {
      emit(TranscriptionLoading());

      final TextQuestion question = TextQuestion(questionText: event.question);

      final Either<Failure, Answer> response =
          await askTextQuestionUseCase(question);

      response.fold(
          (Failure failure) =>
              emit(TranscriptionFailure(message: failure.message)),
          (Answer answer) =>
              emit(TranscriptionSuccess(answerAudio: answer.answerAudio)));
    });
  }
}
