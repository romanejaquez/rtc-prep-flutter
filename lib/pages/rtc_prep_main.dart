import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_exam.dart';
import 'package:flutter_rtc_prep/providers/exam_providers.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:flutter_rtc_prep/widgets/google_cloud_animated.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RTCPrepMain extends StatelessWidget {

  static const String route = '/main';
  const RTCPrepMain({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: RTCPrepStyles.largePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    width: 100, height: 100,
                    child: GoogleCloudAnimLogo()
                  ),
                  RTCPrepStyles.smallVGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('./assets/imgs/gdglawrence_mon.svg',
                        width: 80, height: 80, fit: BoxFit.contain,
                      ),
                      RTCPrepStyles.xsmallHGap,
                      SvgPicture.asset('./assets/imgs/gdglawrence_text.svg',
                        width: 200, height: 80, fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  RTCPrepStyles.mediumVGap,
                  const Text('Road To Certification', textAlign: TextAlign.center, style: RTCPrepStyles.headlineMedium),
                  RTCPrepStyles.smallVGap,
                  Container(
                    decoration: BoxDecoration(
                      color: RTCPrepColors.yellow,
                      borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius)
                    ),
                    padding: RTCPrepStyles.smallPadding.copyWith(
                      left: RTCPrepStyles.smallSize, right: RTCPrepStyles.smallSize, 
                    ),
                    child: Text('Professional Cloud Architect', textAlign: TextAlign.center, style: RTCPrepStyles.headlineSmall),
                  ),
                  RTCPrepStyles.smallVGap,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: RTCPrepColors.brightBlue.withOpacity(0.125),
                        borderRadius: BorderRadius.circular(RTCPrepStyles.smallRadius)
                      ),
                      padding: RTCPrepStyles.mediumPadding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: RTCPrepColors.brightBlue,
                              borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius)
                            ),
                            padding: RTCPrepStyles.smallPadding.copyWith(
                              left: RTCPrepStyles.smallSize, right: RTCPrepStyles.smallSize, 
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.quiz, color: Colors.black),
                                RTCPrepStyles.xxsmallHGap,
                                Text('Mock Test Prep', style: RTCPrepStyles.headlineSmall),
                              ],
                            ),
                          ),
                          RTCPrepStyles.xsmallVGap,
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Note:', textAlign: TextAlign.left, style: RTCPrepStyles.headlineSmall),
                                  Text('This is a compilation of prep questions for the Professional Cloud Architect Certification study group, led by GDG Lawrence.\n\nThis is not meant to be material for you to go study from only and then take the exam. You MUST study for the exam from multiple sources.\n\nThe questions here are collected from the internet, and we are not responsible whether the question might be wrong, but we did our best to get the best answers. It is meant to be ONLY a preparation for that exam, so you get a feel for the testing experience.'),
                                  RTCPrepStyles.smallVGap,
                                  Row(
                                    children: [
                                      Consumer(
                                        builder: (context, ref, child) {
                                                    
                                          final agreement = ref.watch(agreementCheckProvider);
                                          return Checkbox(value: agreement, onChanged: (value) {
                                            ref.read(agreementCheckProvider.notifier).state = value!;
                                          });
                                        },
                                      ),
                                      const SizedBox(child: Text('I understand. I will proceed.', style: RTCPrepStyles.headlineSmall))
                                    ],
                                  ),
                                  RTCPrepStyles.smallVGap,
                                ],
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                  )
                ].animate(
                  interval: 50.ms,
                ).slideY(
                  begin: 0.25, end: 0,
                  duration: 0.25.seconds,
                  curve: Curves.easeInOut,
                ).fadeIn(
                  duration: 0.25.seconds,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            RTCPrepStyles.smallVGap,
            Consumer(
              builder: (context, ref, child) {

                final agreementValue = ref.watch(agreementCheckProvider);

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: RTCPrepColors.brightBlue,
                  ),
                  onPressed: agreementValue ? () {
                      Router.neglect(context, () => context.go(RTCPrepExam.route));
                  } : null,
                  child: const Padding(
                    padding: RTCPrepStyles.smallPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag_circle, color: Colors.white),
                        RTCPrepStyles.xsmallHGap,
                        Text('Start Exam', style: RTCPrepStyles.headlineSmall),
                      ],
                    ),
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}