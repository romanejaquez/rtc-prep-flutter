import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/models/exam_result.model.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';

class FinalGradeService {

  final Ref ref;
  FinalGradeService(this.ref);

  Future<ExamResult> finalGrade() {
    final completerResult = Completer<ExamResult>();

    Future.delayed(Duration(seconds: 3), () {

      var allQuestions = ref.read(examQuestionsVM);
      var totalQuestions = allQuestions.length;
      var correctQuestions = 0;
      

      allQuestions.forEach((element) {
        var isCorrect = element.options.where((o) => o.isSelected && o.correct).length;
        if (isCorrect > 0) {
          correctQuestions++;
        }
      });

      var allWrong = totalQuestions - correctQuestions;
      var finalGrade = correctQuestions > 0 ? (correctQuestions / totalQuestions) * 100 : 0.0;

      completerResult.complete(ExamResult(
        score: finalGrade, 
        wrongQuestions: allWrong, 
        correctQuestions: correctQuestions, 
        passed: finalGrade >= 70
      ));

    });

    return completerResult.future;
  }
}