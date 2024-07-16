import 'package:youtube_bloc_clean_coding/config/app_url.dart';
import 'package:youtube_bloc_clean_coding/data/network/network_services.dart';
import 'package:youtube_bloc_clean_coding/model/user/user_model.dart';
import 'package:youtube_bloc_clean_coding/repository/auth/login_repository.dart';

class LoginHttpApiRepository implements LoginRepository{

  final _api = NetworkServices();

  @override
  Future<UserModel> loginApi(dynamic data) async {
    final response = await _api.postApi(AppUrl.loginApi, data);
    return UserModel.fromJson(response);
  }
}