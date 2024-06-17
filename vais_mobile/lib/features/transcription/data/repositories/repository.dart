import 'package:dartz/dartz.dart';
import 'package:vais_mobile/core/errors/exceptions.dart';
import 'package:vais_mobile/features/transcription/data/datasources/remote_data_source.dart';
import 'package:vais_mobile/features/transcription/data/models/answer_model.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/audio_question.dart';
import 'package:vais_mobile/features/transcription/domain/entities/text_question.dart';
import 'package:vais_mobile/features/transcription/domain/repositories/question_repository.dart';

import '../../../../core/errors/failures.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource questionDataSource;

  QuestionRepositoryImpl({
    required this.questionDataSource,
  });

  @override
  Future<Either<Failure, Answer>> askAudioQuestion(
      AudioQuestion question) async {
    try {
      final AnswerModel response =
          await questionDataSource.askAudioQuestion(question);
      return Right<Failure, Answer>(response);
    } on ServerException catch (e) {
      return Left<Failure, Answer>(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Answer>> askTextQuestion(
      TextQuestion textQuestion) async {
    try {
      final AnswerModel response =
          await questionDataSource.askTextQuestion(textQuestion);
      return Right<Failure, Answer>(response);
    } on ServerException catch (e) {
      return Left<Failure, Answer>(ServerFailure(e.message));
    }
  }
}
