import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/question.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/question_usecase.dart';

import '../../../../../core/errors/failures.dart';

part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  final AskQuestionUseCase askQuestionUseCase;
  TranscriptionBloc({required this.askQuestionUseCase})
      : super(TranscriptionInitial()) {
    on<Transcribe>((event, emit) async {
      emit(TranscriptionLoading());

      await Future<dynamic>.delayed(const Duration(seconds: 2));

      final Question question = Question(questionFile: event.question);
      final Either<Failure, Answer> response =
          await askQuestionUseCase(question);

      response.fold(
          (Failure failure) =>
              emit(TranscriptionFailure(message: failure.message)),
          (Answer answer) =>
              emit(TranscriptionSuccess(answerAudio: answer.answerAudio)));
    });
  }
}
