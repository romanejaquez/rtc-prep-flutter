import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:go_router/go_router.dart';

class RTCPrepFinalGrade extends ConsumerWidget {

  static const String route = '/finalgrade';
  const RTCPrepFinalGrade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final examResult = ref.watch(finalGradeProvider);

    return Scaffold(
      body: examResult.when(
        data: (result) {

          return Stack(
            children: [
              Container(
                color: result.passed ? RTCPrepColors.positiveGreen : RTCPrepColors.wrongRed,
              ).animate()
              .slideY(
                begin: 1, end: 0,
                duration: 0.5.seconds,
                curve: Curves.easeInOut,
              ).fadeIn(
                duration: 0.5.seconds,
                curve: Curves.easeInOut,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(result.passed ? Icons.check_circle_outline : Icons.highlight_off, color: Colors.white, size: RTCPrepStyles.x2largeIconSize),
                    RTCPrepStyles.mediumVGap,
                    Text('Your score:', style: RTCPrepStyles.headlineMedium.copyWith(color: Colors.white)),
                    Text('${result.score.toInt()}%', style: RTCPrepStyles.headlineLarge.copyWith(color: Colors.white)),
                    RTCPrepStyles.largeVGap,
                    Text(result.passed ? 'Congrats!! You passed!' : 'You did not reach the minimum score.\nPlease try again.',
                      textAlign: TextAlign.center,
                      style: RTCPrepStyles.labelMedium.copyWith(color: Colors.white)
                    ),
                    RTCPrepStyles.smallVGap,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white.withOpacity(0.25),
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
                ),
              ),
            ],
          );
        }, 
        error:(error, stackTrace) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber, size: RTCPrepStyles.largeIconSize, color: Colors.grey),
                RTCPrepStyles.xsmallVGap,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Text(error.toString(),
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
            ));
        }, 
        loading: () => Center(
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
              Text('Calculating Score...', textAlign: TextAlign.center, style: RTCPrepStyles.headlineSmall.copyWith(
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
          )
        )
      )
    );
  }
}