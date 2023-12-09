import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:flutter_rtc_prep/widgets/exam_question_wrapper_container.dart';
import 'package:flutter_svg/svg.dart';

class RTCPrepExam extends ConsumerWidget {

  static const String route = '/exam';
  const RTCPrepExam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final examQuestions = ref.watch(examProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset('./assets/imgs/gdg_color.svg', height: 30),
        centerTitle: true,
        toolbarHeight: 45,
      ),
      body: examQuestions.when(
        data: (examData) {
          
          return const ExamQuestionWrapperContainer();
        }, 
        error: (e, s) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber, size: RTCPrepStyles.largeIconSize, color: Colors.grey),
                RTCPrepStyles.xsmallVGap,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Text(e.toString(),
                    textAlign: TextAlign.center,
                    style: RTCPrepStyles.headlineSmall.copyWith(
                      color: Colors.grey
                    )
                  )
                ),
                RTCPrepStyles.xsmallVGap,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.black.withOpacity(0.25),
                    elevation: 0,
                    shadowColor: Colors.transparent
                  ),
                  onPressed: () {
                    ref.read(examQuestionsVM.notifier).backToMain(context);
                  },
                  child: Text('Back to Main', style: RTCPrepStyles.headlineSmall.copyWith(color: Colors.white))
                )
              ].animate(
                interval: 100.ms,
              ).slideY(
                begin: 0.5, end: 0,
                duration: 0.5.seconds,
                curve: Curves.easeInOut
              ).fadeIn(
                duration: 0.5.seconds,
                curve: Curves.easeInOut
              ),
            )),
            
        loading: () => 
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50, height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(RTCPrepColors.brightBlue),
                  ),
                ),
                RTCPrepStyles.smallVGap,
                Text('Loading Exam', textAlign: TextAlign.center, style: RTCPrepStyles.headlineSmall.copyWith(
                  color: RTCPrepColors.brightBlue
                )),
                RTCPrepStyles.smallVGap,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3,
                    (index) => Container(
                      margin: const EdgeInsets.all(RTCPrepStyles.smallSize),
                      width: 20, height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: RTCPrepColors.brightBlue,
                      ),
                    )
                  ).animate(
                    interval: 250.ms,
                    onComplete:(controller) {
                      controller.repeat(reverse: true);
                    },
                  ).fadeIn(
                    curve: Curves.easeInOut,
                    duration: 0.5.seconds,
                  ),
                )
              ],
            ),
          )
      )
    );
  }
}