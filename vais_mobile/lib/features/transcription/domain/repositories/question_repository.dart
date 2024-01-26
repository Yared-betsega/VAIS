import 'package:dartz/dartz.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/question.dart';
import '../../../../core/errors/failures.dart';

abstract class QuestionRepository {
  Future<Either<Failure, Answer>> askQuestion(Question question);
}
