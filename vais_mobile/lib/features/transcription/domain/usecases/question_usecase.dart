import 'package:dartz/dartz.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/question.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/question_repository.dart';

class AskQuestionUseCase implements UseCase<Answer, Question> {
  final QuestionRepository questionRepository;

  AskQuestionUseCase({required this.questionRepository});

  @override
  Future<Either<Failure, Answer>> call(Question question) async {
    return await questionRepository.askQuestion(question);
  }
}
