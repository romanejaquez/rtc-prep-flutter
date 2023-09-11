import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_main.dart';
import 'package:flutter_rtc_prep/styles/colors.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:flutter_rtc_prep/widgets/google_cloud_loading.dart';
import 'package:go_router/go_router.dart';

class RTCPrepSplash extends StatefulWidget {

  static const String route = '/';

  const RTCPrepSplash({super.key});

  @override
  State<RTCPrepSplash> createState() => _RTCPrepSplashState();
}

class _RTCPrepSplashState extends State<RTCPrepSplash> {

  Timer splashTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    splashTimer = Timer(Duration(seconds: 2), () {
      Router.neglect(context, () => context.go(RTCPrepMain.route)); 
    });

  }

  @override
  void dispose() {
    splashTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: RTCPrepColors.loadingBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      height:100,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(0.5)),
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 60, height: 60,
                      child: GoogleCloudLoadingLogo())
                  )
                ],
              )
            ),
            
            Container(
              margin: const EdgeInsets.only(top: RTCPrepStyles.mediumSize),
              child: Text('Road to Certification', style: RTCPrepStyles.headlineSmall.copyWith(
                color: Colors.white,
              ))),
            Text('Professional Cloud Architect', style: RTCPrepStyles.labelLarge.copyWith(
              color: Colors.white,
            )),
            RTCPrepStyles.smallVGap,
            Container(
              padding: RTCPrepStyles.mediumPadding.copyWith(
                left: RTCPrepStyles.mediumSize,
                right: RTCPrepStyles.mediumSize,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(RTCPrepStyles.largeRadius),
              ),
              child: Text('Test Prep', style: RTCPrepStyles.labelMedium.copyWith(
                color: Colors.white,
              )
            ),
            )
          ].animate(
            interval: 150.ms,
          ).slideY(
            begin: 0.25, end: 0,
            curve: Curves.easeInOut,
            duration: 0.5.seconds,
          ).fadeIn(
            curve: Curves.easeInOut,
            duration: 0.5.seconds,
          ),
        )
      ),
    );
  }
}