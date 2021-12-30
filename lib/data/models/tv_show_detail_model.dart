import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowDetailResponse extends Equatable {
  TvShowDetailResponse(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.status,
      required this.voteAverage,
      required this.voteCount,
      required this.numberOfSeasons});

  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;

  factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvShowDetailResponse(
          backdropPath: json["backdrop_path"],
          firstAirDate: json["first_air_date"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          id: json["id"],
          name: json["name"],
          overview: json["overview"],
          popularity: json["popularity"],
          posterPath: json["poster_path"],
          status: json["status"],
          voteAverage: json["vote_average"],
          voteCount: json["vote_count"],
          numberOfSeasons: json["number_of_seasons"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "number_of_seasons": numberOfSeasons
      };

  TvShowDetail toEntity() {
    return TvShowDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        name: this.name,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        status: this.status,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
        numberOfSeasons: this.numberOfSeasons);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        overview,
        popularity,
        posterPath,
        status,
        voteAverage,
        voteCount,
        numberOfSeasons,
      ];
}
