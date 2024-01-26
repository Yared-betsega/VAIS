import 'package:dartz/dartz.dart';
import 'package:vais_mobile/core/errors/exceptions.dart';
import 'package:vais_mobile/features/transcription/data/datasources/remote_data_source.dart';
import 'package:vais_mobile/features/transcription/data/models/answer_model.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/question.dart';
import 'package:vais_mobile/features/transcription/domain/repositories/question_repository.dart';

import '../../../../core/errors/failures.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource questionDataSource;

  QuestionRepositoryImpl({
    required this.questionDataSource,
  });

  @override
  Future<Either<Failure, Answer>> askQuestion(Question question) async {
    try {
      final AnswerModel response =
          await questionDataSource.askQuestion(question);
      return Right<Failure, Answer>(response);
    } on ServerException {
      return const Left<Failure, Answer>(ServerFailure("Server Failure"));
    }
  }
}
