import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';

class AnswerModel extends Answer {
  AnswerModel({required super.answerText});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    print("json $json");
    return AnswerModel(answerText: json["text"]);
  }
}
