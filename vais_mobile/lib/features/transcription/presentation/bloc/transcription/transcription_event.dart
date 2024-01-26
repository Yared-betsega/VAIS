part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionEvent {}

final class Transcribe extends TranscriptionEvent {
  final String questionPath;

  Transcribe(this.questionPath);
}
