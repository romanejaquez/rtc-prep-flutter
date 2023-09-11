import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';
import 'package:flutter_rtc_prep/models/question_option.model.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_main.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_results.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:go_router/go_router.dart';

class ExamQuestionsViewModel extends StateNotifier<List<ExamQuestion>> {
  
  final Ref ref;
  int _currentQuestionIndex = -1;
  ExamQuestionsViewModel(super.state, this.ref);

  int getCurrentQuestionIndex() {
    return _currentQuestionIndex + 1;
  }

  void initializeExam(List<ExamQuestion> questions) {
    state = [
      for(final (index, question) in questions.indexed)
        question.copyWith(
          currentQuestion: index == 0,
          options: question.options.map((o) => o.copyWith(isSelected: false)).toList()
        )
    ];

    _currentQuestionIndex = 0;
    ref.read(examQuestionVM.notifier).state = getCurrentQuestion();
  }

  ExamQuestion getCurrentQuestion() {
    return state.firstWhere((e) => e.currentQuestion);
  }

  bool canMoveToNext() {
    return ref.read(examQuestionVM.notifier).isAnswered() && (_currentQuestionIndex < state.length - 1 || isLastQuestion());
  }

  bool canMoveToPrevious() {
    return _currentQuestionIndex > 0;
  }

  void moveToPrevious() {
    _currentQuestionIndex--;

    state = [
      for(final (index, question) in state.indexed)
        question.copyWith(currentQuestion: index == _currentQuestionIndex)
    ];

    ref.read(examQuestionVM.notifier).state = getCurrentQuestion();
  }

  bool isLastQuestion() {
    return _currentQuestionIndex == state.length - 1;
  }

  void moveToNext(BuildContext context) {

    if (isLastQuestion()) {
      Router.neglect(context, () => context.go(RTCPrepExamResults.route)); 
      return;
    }

    _currentQuestionIndex++;

    state = [
      for(final (index, question) in state.indexed)
        question.copyWith(currentQuestion: index == _currentQuestionIndex)
    ];

    ref.read(examQuestionVM.notifier).state = getCurrentQuestion();
  }

  void markSelected(ExamQuestion question, QuestionOption option) {
    List<QuestionOption> questionOptions = [];
    
    if (question.optionType == ExamQuestionOptionType.singleChoice) {
      questionOptions = [
        for(final op in question.options)
          op.copyWith(isSelected: option == op)
      ];
    }
    else {
      questionOptions = [
        for(final op in question.options)
          if (op == option)
            op.copyWith(isSelected: !option.isSelected)
          else 
            op
      ];
    }

    state = [
      for(final q in state)
        if (q.currentQuestion == question.currentQuestion)
          q.copyWith(options: questionOptions)
        else 
          q
    ];

    ref.read(examQuestionVM.notifier).state = getCurrentQuestion();
  }

  void revealCorrectAnswer() {
    state = [
      for(final question in state)
        if (question.currentQuestion)
          question.copyWith(revealCorrectAnswer: !question.revealCorrectAnswer)
        else
          question 
        
    ];

    ref.read(examQuestionVM.notifier).state = getCurrentQuestion();
  }

  void finishExam(BuildContext context) {

    // still, go to the results page
    Router.neglect(context, () => context.go(RTCPrepExamResults.route));
  }

  void backToMain(BuildContext context) {
    if (state.isNotEmpty) {
      initializeExam(state);
    }
    Router.neglect(context, () => context.go(RTCPrepMain.route));
  }
}