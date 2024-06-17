import 'package:dartz/dartz.dart';
import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';
import 'package:vais_mobile/features/transcription/domain/entities/audio_question.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/question_repository.dart';

class AskAudioQuestionUseCase implements UseCase<Answer, AudioQuestion> {
  final QuestionRepository questionRepository;

  AskAudioQuestionUseCase({required this.questionRepository});

  @override
  Future<Either<Failure, Answer>> call(AudioQuestion question) async {
    return await questionRepository.askAudioQuestion(question);
  }
}
