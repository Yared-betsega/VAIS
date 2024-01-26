part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionState {}

final class TranscriptionInitial extends TranscriptionState {}

final class TranscriptionLoading extends TranscriptionState {}

final class TranscriptionSuccess extends TranscriptionState {
  final String questionAsText;

  TranscriptionSuccess({required this.questionAsText});
}

final class TranscriptionFailure extends TranscriptionState {
  final String message;

  TranscriptionFailure({required this.message});
}
