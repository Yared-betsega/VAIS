import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:vais_mobile/core/errors/exceptions.dart';
import 'package:vais_mobile/features/transcription/data/models/answer_model.dart';
import 'package:vais_mobile/features/transcription/domain/entities/text_question.dart';

import '../../domain/entities/audio_question.dart';

abstract class QuestionRemoteDataSource {
  Future<AnswerModel> askAudioQuestion(AudioQuestion question);
  Future<AnswerModel> askTextQuestion(TextQuestion question);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://6705-185-177-124-191.ngrok-free.app';

  QuestionRemoteDataSourceImpl({required this.client});

  @override
  Future<AnswerModel> askAudioQuestion(AudioQuestion question) async {
    try {
      print("REached here 1");
      final audioQuestion = File(question.questionFile.path);
      print("REAched here 2");
      var uri = Uri.parse("$baseUrl/upload/");
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
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        final streamedResponse = response.stream;

        final tempDir = await Directory.systemTemp.createTemp();
        Directory dir =
            Directory(path.dirname("/sdcard/Download/VAIS/temp.wav"));
        if (!dir.existsSync()) {
          dir.createSync();
        }

        final file = File('/sdcard/Download/VAIS/temp.wav');

        await file.writeAsBytes(await streamedResponse.toBytes());

        print(file);
        // Return AnswerModel with the audio file
        return AnswerModel.fromJson(file);
      }
      print("Reached here 6");
      throw ServerException(response.toString());
    } catch (e) {
      print(e);
      throw ServerException("Server Failure");
      // return VerifyOtpModel.fromJson(jsonDecode(response.body));
    }
  }

  @override
  Future<AnswerModel> askTextQuestion(TextQuestion question) async {
    try {
      print("REached here 1");
      var uri = Uri.parse("$baseUrl/text");
      print("Reached here 3");

      var request = http.MultipartRequest('POST', uri)
        ..fields['text'] = question.questionText;

      print("Reached here 5");
      var response = await request.send();
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        final streamedResponse = response.stream;

        final tempDir = await Directory.systemTemp.createTemp();
        Directory dir =
            Directory(path.dirname("/sdcard/Download/VAIS/temp.wav"));
        if (!dir.existsSync()) {
          dir.createSync();
        }

        final file = File('/sdcard/Download/VAIS/temp.wav');

        await file.writeAsBytes(await streamedResponse.toBytes());

        print(file);
        // Return AnswerModel with the audio file
        return AnswerModel.fromJson(file);
      }
      print("Reached here 6");
      throw ServerException(response.toString());
    } catch (e) {
      print(e);
      throw ServerException("የውስጥ መቆጣጠርያ ችግር አጋጥሞዋል");
      // return VerifyOtpModel.fromJson(jsonDecode(response.body));
    }
  }
}
