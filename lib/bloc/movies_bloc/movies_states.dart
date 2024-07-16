part of 'movies_bloc.dart';

class MoviesStates extends Equatable{

  final ApiResponse<MoviesModel> moviesList;

  const MoviesStates({required this.moviesList});

  MoviesStates copyWith({ApiResponse<MoviesModel>? moviesList}){
    return MoviesStates(moviesList: moviesList ?? this.moviesList);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [moviesList];
}