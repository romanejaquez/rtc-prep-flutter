import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/models/exam_question.model.dart';
import 'package:flutter_rtc_prep/models/question_option.model.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';

class QuestionOptionContainer extends ConsumerStatefulWidget {

  final ExamQuestion question;
  final QuestionOption option;
  const QuestionOptionContainer({
    required this.question,
    required this.option,
    super.key});

  ConsumerState<QuestionOptionContainer> createState() => QuestionOptionContainerState();
}

class QuestionOptionContainerState extends ConsumerState<QuestionOptionContainer> {

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {

    late IconData selectedIcon;
    late IconData unselectedIcon;

    switch(widget.question.optionType) {
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

    var bgColor = Colors.transparent;
    var labelColor = Colors.black;
    
    if (widget.question.revealCorrectAnswer) {
      if (widget.option.correct) {
        bgColor = RTCPrepColors.brightBlue;
      }
      else if (widget.option.isSelected && !widget.option.correct) {
        bgColor = RTCPrepColors.wrongRed;
        labelColor = Colors.white;
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius),
        color: bgColor,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onHover: (value) {
            setState(() {
              isHovering = value;
            });
          },
          onTap: () {
            ref.read(examQuestionsVM.notifier).markSelected(widget.question, widget.option);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(widget.option.isSelected ? selectedIcon : unselectedIcon, color: labelColor),
                const SizedBox(width: 20),
                Expanded(child: Text('${widget.option.optionLetter}. ${widget.option.title}',
                  style: RTCPrepStyles.labelMedium.copyWith(
                    fontWeight: widget.option.isSelected ? FontWeight.bold : FontWeight.normal,
                    color: labelColor,
                  )
                )),
              ],
            )
          ),
        ),
      ),
    );
  }
}