import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_bloc_clean_coding/config/rotues/routes_name.dart';
import 'package:youtube_bloc_clean_coding/services/session_manager/session_controller.dart';

class SplashService {
  void isLogin(BuildContext context) {
    SessionController().getUserFromPreference().then((value) {
      if (SessionController().isLogin ?? false) {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.homeScreen, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.loginScreen, (route) => false),
        );
      }
    }).onError((error, stckTracce) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.loginScreen, (route) => false),
      );
    });
  }
}
