import 'package:vais_mobile/features/transcription/data/datasources/remote_data_source.dart';
import 'package:vais_mobile/features/transcription/data/repositories/repository.dart';
import 'package:vais_mobile/features/transcription/domain/repositories/question_repository.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/audio_question_usecase.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/text_question_usecase.dart';
import 'package:vais_mobile/features/transcription/presentation/bloc/question/transcription_bloc.dart';

import 'injection_container.dart';

Future<void> transcriptionInjectionInit() async {
  // Bloc
  sl.registerFactory(() => TranscriptionBloc(
      askAudioQuestionUseCase: sl(), askTextQuestionUseCase: sl()));

  // usecase
  sl.registerLazySingleton<AskAudioQuestionUseCase>(
    () => AskAudioQuestionUseCase(questionRepository: sl<QuestionRepository>()),
  );

  sl.registerLazySingleton<AskTextQuestionUseCase>(
    () => AskTextQuestionUseCase(questionRepository: sl<QuestionRepository>()),
  );

  // Repositories
  sl.registerLazySingleton<QuestionRepository>(
    () => QuestionRepositoryImpl(
        questionDataSource: sl<QuestionRemoteDataSource>()),
  );

  // Data Sources
  sl.registerLazySingleton<QuestionRemoteDataSource>(
    () => QuestionRemoteDataSourceImpl(client: sl()),
  );
}
