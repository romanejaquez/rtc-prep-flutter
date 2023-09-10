import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';

class ExamQuestionsRepository {

  Future<List<ExamQuestion>> getQuestions() async {
    final completer = Completer<List<ExamQuestion>>();

    http.get(Uri.parse('http://localhost:8080/exam-prep')).then((response) {
      final responseBody = json.decode(response.body) as List<dynamic>;
      responseBody.shuffle();
      final payload = responseBody.map((e) => ExamQuestion.fromJson(e as Map<String, dynamic>)).toList();

      completer.complete(payload);
    }).catchError((error) {
      completer.completeError(error.toString());
    }).onError((error, stackTrace) {
      completer.completeError(error.toString());
    });

    return completer.future;
  }
}