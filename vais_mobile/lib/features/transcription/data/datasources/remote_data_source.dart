import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vais_mobile/core/errors/exceptions.dart';
import 'package:vais_mobile/features/transcription/data/models/answer_model.dart';

import '../../domain/entities/question.dart';

abstract class QuestionRemoteDataSource {
  Future<AnswerModel> askQuestion(Question question);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'http://localhost:5000/transcribe';

  QuestionRemoteDataSourceImpl({required this.client});

  @override
  Future<AnswerModel> askQuestion(Question question) async {
    try {
      final audioQuestion = File(question.questionFile.path);
      var uri = Uri.parse(baseUrl);
      final jsonBody = {"file": audioQuestion};
      final http.Response response =
          await http.post(uri, body: json.encode(jsonBody));
      // ..files
      //     .add(await http.MultipartFile.fromPath('file', audioQuestion.path));

      // var response = await request.send();

      return AnswerModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw ServerException("Server Failure");
      // return VerifyOtpModel.fromJson(jsonDecode(response.body));
    }
  }
}
