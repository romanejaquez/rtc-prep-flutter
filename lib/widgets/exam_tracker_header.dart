import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';

class ExamTrackerHeader extends ConsumerWidget {
  const ExamTrackerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final allQuestions = ref.watch(examQuestionsVM);
    final currentQuestionIndex = ref.read(examQuestionsVM.notifier).getCurrentQuestionIndex();
    final totalNumberOfQuestions = allQuestions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$currentQuestionIndex out of $totalNumberOfQuestions', textAlign: TextAlign.left,
          style: RTCPrepStyles.labelLarge.copyWith(
            color: RTCPrepColors.brightOrange,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 30,
          padding: const EdgeInsets.all(RTCPrepStyles.xsmallSize),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius),
            color: RTCPrepColors.brightOrange.withOpacity(0.25)
          ),
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            widthFactor: currentQuestionIndex / totalNumberOfQuestions,
            heightFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius),
                color: RTCPrepColors.brightOrange
              ),
            ),
          ),
        )
      ],
    );
  }
}