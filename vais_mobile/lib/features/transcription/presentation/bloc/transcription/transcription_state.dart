part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionState {}

final class TranscriptionInitial extends TranscriptionState {}

final class TranscriptionLoading extends TranscriptionState {}

final class TranscriptionSuccess extends TranscriptionState {
  final String answerText;

  TranscriptionSuccess({required this.answerText});
}

final class TranscriptionFailure extends TranscriptionState {
  final String message;

  TranscriptionFailure({required this.message});
}
