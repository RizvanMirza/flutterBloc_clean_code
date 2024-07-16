import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_bloc_clean_coding/bloc/login/login_bloc.dart';
import 'package:youtube_bloc_clean_coding/config/rotues/routes_name.dart';
import 'package:youtube_bloc_clean_coding/utils/enums.dart';
import 'package:youtube_bloc_clean_coding/utils/flush_bar_helper.dart';

class LoginButton extends StatelessWidget {
  final formKey;
  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (previous, current) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          FlushBarHelper.flushBarErrorMessgae(state.message.toString(), context);
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(
          //       content: Text(state.message.toString()),
          //     ),
          //   );
        }
        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.homeScreen, (route) => false);
         //FlushBarHelper.flushBarSucessMessgae(state.message.toString(), context);
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(
          //       content: Text(state.message.toString()),
          //     ),
          //   );
        }
        
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (previous, current) => previous.postApiStatus != current.postApiStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApi());
              }
            },
            child: state.postApiStatus == PostApiStatus.loading
                ? const CircularProgressIndicator()
                : const Text('Login'),
          );
        },
      ),
    );
  }
}
