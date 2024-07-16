import 'package:flutter/material.dart';
import 'package:youtube_bloc_clean_coding/config/components/internet_exception_widget.dart';
import 'package:youtube_bloc_clean_coding/data/exception/app_exception.dart';
import 'package:youtube_bloc_clean_coding/services/splash/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService _splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     throw NoInternetException("");
      //   },
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Splash Screen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // InternetExceptionWidget(
                //   onPress: () {},
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
