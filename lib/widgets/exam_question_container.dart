import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:flutter_rtc_prep/widgets/question_option_container.dart';

class ExamQuestionContainer extends ConsumerWidget {

  const ExamQuestionContainer({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final question = ref.watch(examQuestionVM);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey(ref.read(examQuestionsVM.notifier).getCurrentQuestionIndex().toDouble()),
      children: [
        Text(
          question.title,
          style: RTCPrepStyles.headlineSmall,
        )
        .animate()
        .slideX(
            begin: 0.25,
            end: 0,
            curve: Curves.easeInOut,
            duration: 0.4.seconds,
          ).fadeIn(
            curve: Curves.easeInOut,
            duration: 0.5.seconds,
          ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              key: ValueKey(ref.read(examQuestionsVM.notifier).getCurrentQuestionIndex().toDouble()),
              children: [
                for(final option in question.options)
                  QuestionOptionContainer(question: question, option: option)
              ].animate(
                interval: 100.ms,
                delay: 100.ms,
              ).slideX(
                begin: 0.25,
                end: 0,
                curve: Curves.easeInOut,
                duration: 0.4.seconds,
              ).fadeIn(
                curve: Curves.easeInOut,
                duration: 0.5.seconds,
              ),
            ),
          ),
        )
      ],
    );
  }
}