import 'package:flutter_rtc_prep/pages/rtc_prep_exam.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_final_grade.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_main.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_options.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_results.dart';
import 'package:flutter_rtc_prep/pages/rtc_prep_splash.dart';
import 'package:go_router/go_router.dart';


class AppRoutes {

  static final router = GoRouter(
    routerNeglect: true,
    initialLocation:  RTCPrepSplash.route,
    routes: [
      GoRoute(
        path: RTCPrepSplash.route,
        builder: (context, state) {
          return RTCPrepSplash();
        },
      ),
        GoRoute(
            path: RTCPrepMain.route,
            builder: (context, state) {
              return RTCPrepMain();
            },
          ),
          GoRoute(
            path: RTCPrepOptions.route,
            builder: (context, state) {
              return RTCPrepOptions();
            },
          ),
          GoRoute(
            path: RTCPrepExam.route,
            builder: (context, state) {
              return RTCPrepExam();
            },
          ),
          GoRoute(
            path: RTCPrepExamResults.route,
            builder: (context, state) {
              return RTCPrepExamResults();
            },
          ),
          GoRoute(
            path: RTCPrepFinalGrade.route,
            builder: (context, state) {
              return RTCPrepFinalGrade();
            },
          ),
    ]
  );
}