import 'package:flutter/material.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_exam.dart';
import 'package:go_router/go_router.dart';

class RTCPrepMain extends StatelessWidget {

  static const String route = '/main';
  const RTCPrepMain({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go(RTCPrepExam.route);
          },
          child: Text('go to exam')  
        ),
      ),
    );
  }
}