import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_container.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_wrapper_container.dart';

class RTCPrepExam extends ConsumerWidget {

  static const String route = '/exam';
  const RTCPrepExam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final examQuestions = ref.watch(examProvider);

    return Scaffold(
      body: examQuestions.when(
        data: (examData) {
          
          return ExamQuestionWrapperContainer();
        }, 
        error: (e, s) => Text('loading'),
        loading: () => Text('loading')
      )
    );
  }
}