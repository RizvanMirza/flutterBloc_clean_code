import 'package:youtube_bloc_clean_coding/model/user/user_model.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_repository.dart';

class LoginMockApiRepository implements LoginRepository{


  @override
  Future<UserModel> loginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = {'token': 'QpwL5tke4Pnpja7X4'};
    
    return UserModel.fromJson(response);
  }
}