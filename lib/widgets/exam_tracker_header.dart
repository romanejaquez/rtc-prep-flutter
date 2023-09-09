import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';

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
        Text('$currentQuestionIndex out of $totalNumberOfQuestions', textAlign: TextAlign.left,),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 20,
          child: FractionallySizedBox(
            widthFactor: currentQuestionIndex / totalNumberOfQuestions,
            heightFactor: 1,
            child: Container(
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}