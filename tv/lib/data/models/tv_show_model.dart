import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_show.dart';

class TvShowModel extends Equatable {
  const TvShowModel(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory TvShowModel.fromJson(Map<String, dynamic> json) => TvShowModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  TvShow toEntity() {
    return TvShow(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      id: id,
      name: name,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
        voteCount,
      ];
}
