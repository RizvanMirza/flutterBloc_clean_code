import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_bloc_clean_coding/data/responce/api_response.dart';
import 'package:youtube_bloc_clean_coding/model/movies/movies.dart';
import 'package:youtube_bloc_clean_coding/repository/movies/movies_repository.dart';

part 'movies_evets.dart';
part 'movies_states.dart';

class MoviesBloc extends Bloc<MoviesEvets, MoviesStates>{
  
  MoviesRepository moviesRepository;

  MoviesBloc({required this.moviesRepository}): super(MoviesStates(moviesList: ApiResponse.loading())){
    on<MoviesFetched>(fetchMoviesListApi);
  }


  Future<void> fetchMoviesListApi (MoviesFetched events, Emitter<MoviesStates> emit) async {
    
    await moviesRepository.fetchMoviesList().then((value){
      
      if (kDebugMode) {
        print("\nOnValue: $value");
      }

      emit(state.copyWith(moviesList: ApiResponse.completed(value)));

    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("OnError: $error.toString()");
      }
      emit(state.copyWith(moviesList: ApiResponse.error(error.toString())));
    },);
  }

}