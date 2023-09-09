import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';

class ExamQuestionViewModel extends StateNotifier<ExamQuestion> {

  ExamQuestionViewModel(super.state);

  bool isAnswered() {
    switch(state.optionType) {
      case ExamQuestionOptionType.singleChoice:
        return state.options.where((o) => o.isSelected).length == 1;
      case ExamQuestionOptionType.multipleChoice:
        return state.options.where((o) => o.isSelected).length > 1;
      default:
        return false;
    }
  }
}