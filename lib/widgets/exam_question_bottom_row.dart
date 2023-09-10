import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';

class ExamQuestionBottomRow extends ConsumerWidget {
  const ExamQuestionBottomRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(examQuestionsVM);
    final examVMNotifier = ref.read(examQuestionsVM.notifier);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: RTCPrepColors.brightBlue,
              ),
              onPressed: examVMNotifier.canMoveToPrevious() ? () {
                examVMNotifier.moveToPrevious();
              } : null,
              child: Padding(
                padding: RTCPrepStyles.smallPadding,
                child: Row(
                  children: [
                    Icon(Icons.chevron_left),
                  
                    Text('Prev', style: RTCPrepStyles.headlineSmall)
                  ],
                ),
              )
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: RTCPrepColors.positiveGreen,
              ),
              onPressed: examVMNotifier.canMoveToNext() ? () {
                  examVMNotifier.moveToNext(context);
                } : null,
              child: Padding(
                padding: RTCPrepStyles.smallPadding,
                child: Row(
                  children: [
                    Text(examVMNotifier.isLastQuestion() ? 'Finish' : 'Next', style: RTCPrepStyles.headlineSmall),
                    Icon(Icons.chevron_right),
                  ],
                ),
              )
            ),
          ],
        ),
        RTCPrepStyles.smallVGap,
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            side: BorderSide(
              color: examVMNotifier.canMoveToNext() ? RTCPrepColors.brightBlue : Colors.grey.withOpacity(0.5),
              width: 3),
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          onPressed: examVMNotifier.canMoveToNext() ? () {
              examVMNotifier.revealCorrectAnswer();
            } : null,
          child: Padding(
            padding: RTCPrepStyles.smallPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chevron_right, color: examVMNotifier.canMoveToNext() ? RTCPrepColors.brightBlue : Colors.grey.withOpacity(0.5)),
                Text('Reveal Correct Answer', textAlign: TextAlign.center, style: RTCPrepStyles.headlineSmall.copyWith(
                  color: examVMNotifier.canMoveToNext() ? RTCPrepColors.brightBlue : Colors.grey.withOpacity(0.5)
                )),
              ],
            ),
          )
        ),
      ],
    );
  }
}