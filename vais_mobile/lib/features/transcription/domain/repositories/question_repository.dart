import 'package:dartz/dartz.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/audio_question.dart';
import 'package:vais_mobile/features/transcription/domain/entities/text_question.dart';
import '../../../../core/errors/failures.dart';

abstract class QuestionRepository {
  Future<Either<Failure, Answer>> askAudioQuestion(AudioQuestion question);
  Future<Either<Failure, Answer>> askTextQuestion(TextQuestion textQuestion);
}
