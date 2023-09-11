import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
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
        bool isCorrect = element.options.where((o) => o.isSelected).length == element.options.where((o) => o.correct).length;
        if (isCorrect) {
          correctQuestions++;
        }
      });

      if (correctQuestions > 0) {
        var allWrong = totalQuestions - correctQuestions;
        var finalGrade = (correctQuestions / totalQuestions) * 100;

        completerResult.complete(ExamResult(
          score: finalGrade, 
          wrongQuestions: allWrong, 
          correctQuestions: correctQuestions, 
          passed: finalGrade >= 70
        ));
      }
      else {
        completerResult.completeError('Problem processing exam score. Try again');
      }

    });

    return completerResult.future;
  }
}