import 'package:vais_mobile/features/transcription/data/datasources/remote_data_source.dart';
import 'package:vais_mobile/features/transcription/data/repositories/repository.dart';
import 'package:vais_mobile/features/transcription/domain/repositories/question_repository.dart';
import 'package:vais_mobile/features/transcription/domain/usecases/question_usecase.dart';
import 'package:vais_mobile/features/transcription/presentation/bloc/transcription/transcription_bloc.dart';

import 'injection_container.dart';

Future<void> transcriptionInjectionInit() async {
  // Bloc
  sl.registerFactory(() => TranscriptionBloc(askQuestionUseCase: sl()));

  // usecase
  sl.registerLazySingleton<AskQuestionUseCase>(
    () => AskQuestionUseCase(questionRepository: sl<QuestionRepository>()),
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
