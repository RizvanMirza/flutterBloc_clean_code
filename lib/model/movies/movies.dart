import 'package:freezed_annotation/freezed_annotation.dart';
part 'movies.freezed.dart';
part 'movies.g.dart';

@freezed
class MoviesModel with _$MoviesModel {
  
  factory MoviesModel({
    @Default('') @JsonKey(name: 'total') String total,
    @Default(0) int page,
    @Default(0) int pages,
    @Default([]) @JsonKey(name: 'tv_shows') List<TvShows> tvShows
  }) = _MoviesModel;


  factory MoviesModel.fromJson(Map<String, dynamic> json) => _$MoviesModelFromJson(json);
}

@freezed
class TvShows with _$TvShows {
  
  factory TvShows({
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'pernalink') @Default('') String pernalink,
    @JsonKey(name: 'end_Date') @Default('') String endDate,
    @JsonKey(name: 'network') @Default('') String network,
    @JsonKey(name: 'image_thumbnail_path') @Default('') String imageThumbnailPath,
    @JsonKey(name: 'status') @Default('') String status,
  }) = _TvShows;


  factory TvShows.fromJson(Map<String, dynamic> json) => _$TvShowsFromJson(json);
}