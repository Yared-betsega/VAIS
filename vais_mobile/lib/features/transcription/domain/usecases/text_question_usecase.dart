import 'package:dartz/dartz.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/text_question.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/question_repository.dart';

class AskTextQuestionUseCase implements UseCase<Answer, TextQuestion> {
  final QuestionRepository questionRepository;

  AskTextQuestionUseCase({required this.questionRepository});

  @override
  Future<Either<Failure, Answer>> call(TextQuestion question) async {
    return await questionRepository.askTextQuestion(question);
  }
}
