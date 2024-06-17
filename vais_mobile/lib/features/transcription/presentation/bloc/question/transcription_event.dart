part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionEvent {}

final class AskAudioQuestion extends TranscriptionEvent {
  final File question;

  AskAudioQuestion(this.question);
}

final class AskTextQuestion extends TranscriptionEvent {
  final String question;

  AskTextQuestion({required this.question});
}
