import 'package:flutter/material.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_bottom_row.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_container.dart';
import 'package:flutter_rtc_prep/widgets/exam_tracker_header.dart';

class ExamQuestionWrapperContainer extends StatelessWidget {
  const ExamQuestionWrapperContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return const Padding(
      padding: RTCPrepStyles.largePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExamTrackerHeader(),
          RTCPrepStyles.smallVGap,
          ExamQuestionContainer(),
          RTCPrepStyles.smallVGap,
          ExamQuestionBottomRow()
        ],
      ),
    );
  }
}