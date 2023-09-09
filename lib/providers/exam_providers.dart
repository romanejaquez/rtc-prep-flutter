import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';
import 'package:flutter_rtc_prep/repositories/exam_questions.repository.dart';
import 'package:flutter_rtc_prep/viewmodels/exam_question_viewmodel.dart';
import 'package:flutter_rtc_prep/viewmodels/exam_questions_viewmodel.dart';

final examRepositoryProvider = Provider((ref) {
  return ExamQuestionsRepository();
});

final examProvider = FutureProvider<bool>((ref) async {
  try {
    final questions = await ref.read(examRepositoryProvider).getQuestions();
    ref.read(examQuestionsVM.notifier).initializeExam(questions);
    return true;
  }
  on Exception {
    return false;
  }
});

final examQuestionsVM = StateNotifierProvider<ExamQuestionsViewModel, List<ExamQuestion>>((ref) {
  return ExamQuestionsViewModel([], ref);
});

final examQuestionVM = StateNotifierProvider<ExamQuestionViewModel, ExamQuestion>((ref) {
  return ExamQuestionViewModel(ExamQuestion.empty());
});