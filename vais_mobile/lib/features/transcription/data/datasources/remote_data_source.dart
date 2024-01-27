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
  static const String baseUrl = 'http://192.168.0.172:8000/upload/';

  QuestionRemoteDataSourceImpl({required this.client});

  @override
  Future<AnswerModel> askQuestion(Question question) async {
    try {
      print("REached here 1");
      final audioQuestion = File(question.questionFile.path);
      print("REAched here 2");
      var uri = Uri.parse(baseUrl);
      print("Reached here 3");
      final jsonBody = {"file": audioQuestion};

      print("Reached here 4");
      var request = http.MultipartRequest('POST', uri);

      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        audioQuestion.path,
        filename:
            'temper.wav', // Adjust the filename based on the actual file type
      );
      request.files.add(multipartFile);

      print("Reached here 5");
      var response = await request.send();
      print("Reached here 6");
      var decodedResponse = await response.stream.bytesToString();
      var transcription = jsonDecode(decodedResponse);
      // return transcription;
      // var response = await request.send();
      print("Reached here 5");
      return AnswerModel.fromJson(transcription);
    } catch (e) {
      print(e);
      throw ServerException("Server Failure");
      // return VerifyOtpModel.fromJson(jsonDecode(response.body));
    }
  }
}
