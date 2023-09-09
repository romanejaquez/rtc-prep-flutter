import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';
import 'package:flutter_rtc_prep/models/question_option.model.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';

class QuestionOptionContainer extends ConsumerWidget {

  final ExamQuestion question;
  final QuestionOption option;
  const QuestionOptionContainer({
    required this.question,
    required this.option,
    super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    late IconData selectedIcon;
    late IconData unselectedIcon;

    switch(question.optionType) {
      case ExamQuestionOptionType.multipleChoice:
        selectedIcon = Icons.check_box;
        unselectedIcon = Icons.check_box_outline_blank;
        break;
      case ExamQuestionOptionType.singleChoice:
        selectedIcon = Icons.radio_button_checked;
        unselectedIcon = Icons.radio_button_off;
        break;
      default:
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ref.read(examQuestionsVM.notifier).markSelected(question, option);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(option.isSelected ? selectedIcon : unselectedIcon),
              const SizedBox(width: 20),
              Expanded(child: Text('${option.optionLetter}. ${option.title}')),
            ],
          )
        ),
      ),
    );
  }
}