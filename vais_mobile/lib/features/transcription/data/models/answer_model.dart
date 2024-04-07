import 'dart:io';

import 'package:vais_mobile/features/transcription/domain/entities/answer.dart';

class AnswerModel extends Answer {
  AnswerModel({required super.answerAudio});

  factory AnswerModel.fromJson(File answerAudio) {
    return AnswerModel(answerAudio: answerAudio);
  }
}
