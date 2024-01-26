import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'transcription_injection.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - User
  await transcriptionInjectionInit();

  //! External
  sl.registerLazySingleton(() => http.Client());
}
