import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_repository.dart';
import 'package:youtube_bloc_clean_coding/utils/enums.dart';

import '../../services/session_manager/session_controller.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {

  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<LoginApi>(_loginButton);
  }

  void _emailChanged(EmailChanged events, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(email: events.email),
    );
  }

  void _passwordChanged(PasswordChanged events, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(password: events.password),
    );
  }

  void _loginButton(LoginApi events, Emitter<LoginStates> emit) async {

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    // Map data = {
    //   "email": "eve.holt@reqres.in",
    //   "password": "cityslicka"
    // };
    Map<String, String> data = {"email": state.email, "password": state.password};
    if(kDebugMode){
      print("LoginData: $data");
    }

    

    await loginRepository
        .loginApi(data)
        .then((value) async {
          if(value.error.isNotEmpty){
            emit(state.copyWith(message: value.error.toString(), postApiStatus: PostApiStatus.error));
          }
          else{
            await SessionController().saveUserInPreference(value);
            await SessionController().getUserFromPreference();
            emit(state.copyWith(message: 'Login SuccessFull', postApiStatus: PostApiStatus.success));
            
          }
        })
        .onError((error, stackTrace) {
      emit(state.copyWith(message: error.toString(), postApiStatus: PostApiStatus.error));
    });
  }
}
