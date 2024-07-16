import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_bloc_clean_coding/bloc/login/login_bloc.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_http_api_repository.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_mock_api_repository.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_repository.dart';
import 'package:youtube_bloc_clean_coding/repository/movies/movies_http_api_repository.dart';
import 'package:youtube_bloc_clean_coding/repository/movies/movies_repository.dart';
import 'config/rotues/routes.dart';
import 'config/rotues/routes_name.dart';

GetIt getIt = GetIt.instance;

void main() {
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

void serviceLocator(){
  getIt.registerLazySingleton<LoginRepository>(() => LoginMockApiRepository());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesHttpApiRepository());
}

