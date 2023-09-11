import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_final_grade.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:go_router/go_router.dart';

class RTCPrepExamResults extends ConsumerWidget {

  static const String route = '/results';

  const RTCPrepExamResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final questions = ref.read(examQuestionsVM);

    return Scaffold(
      body: Padding(
        padding: RTCPrepStyles.largePadding,
        child: Column(
        children: [
          Text('Choices Per Question', style: RTCPrepStyles.headlineMedium),
          RTCPrepStyles.smallVGap,
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder:(context, index) {
      
                final question = questions[index];
      
                return Padding(
                  padding: RTCPrepStyles.smallPadding,
                  child: Row(
                    children: [
                      Text('${index + 1}: ${question.options.where((o) => o.isSelected)
                        .map((o) => o.optionLetter).toList().join(', ')}',
                        style: RTCPrepStyles.headlineSmall
                      ),
                    ],
                  ),
                );
              })
          ),
          RTCPrepStyles.smallVGap,
          ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: RTCPrepColors.brightBlue,
                ),
                onPressed: () {
                  Router.neglect(context, () => context.go(RTCPrepFinalGrade.route));
                },
                child: const Padding(
                  padding: RTCPrepStyles.smallPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grade),
                      RTCPrepStyles.xsmallHGap,
                      Text('Grade Exam', style: RTCPrepStyles.headlineSmall)
                    ],
                  ),
                )
              ),
        ],
          ),
      )
    );
  }
}