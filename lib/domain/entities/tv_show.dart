import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  TvShow({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}
