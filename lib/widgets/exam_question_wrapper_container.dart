import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_results.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_container.dart';
import 'package:flutter_rtc_prep/widgets/exam_tracker_header.dart';
import 'package:go_router/go_router.dart';

class ExamQuestionWrapperContainer extends ConsumerWidget {
  const ExamQuestionWrapperContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(examQuestionsVM);
    final examVMNotifier = ref.read(examQuestionsVM.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExamTrackerHeader(),
        const SizedBox(height: 20),
        ExamQuestionContainer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             TextButton(
              onPressed: examVMNotifier.canMoveToPrevious() ? () {
                examVMNotifier.moveToPrevious();
              } : null,
              child: Text('Prev')
            ),

            TextButton(
                onPressed: examVMNotifier.canMoveToNext() ? () {
                  examVMNotifier.moveToNext(context);
                } : null,
                child: Text(examVMNotifier.isLastQuestion() ? 'Finish' : 'Next')
              )
          ],
        )
       
      ],
    );
  }
}