import 'package:youtube_bloc_clean_coding/config/app_url.dart';
import 'package:youtube_bloc_clean_coding/data/network/network_services.dart';
import 'package:youtube_bloc_clean_coding/model/movies/movies.dart';
import 'package:youtube_bloc_clean_coding/repository/movies/movies_repository.dart';

class MoviesHttpApiRepository implements MoviesRepository{

  final _apiServices = NetworkServices();

  @override
  Future<MoviesModel> fetchMoviesList() async {
    final response = await _apiServices.getApi(AppUrl.popularMoviesListEndPoint);
    return MoviesModel.fromJson(response);
  }
}