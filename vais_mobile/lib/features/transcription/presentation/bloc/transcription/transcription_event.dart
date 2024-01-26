part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionEvent {}

final class Transcribe extends TranscriptionEvent {
  final File question;

  Transcribe(this.question);
}
