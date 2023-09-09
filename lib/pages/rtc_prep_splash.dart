import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_main.dart';
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
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}