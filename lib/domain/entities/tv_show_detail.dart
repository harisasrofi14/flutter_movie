import 'package:ditonton/domain/entities/genre.dart';

class TvShowDetail  {
  TvShowDetail({
    required this.backdropPath,
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
    required this.numberOfSeasons,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;

  // @override
  // List<Object?> get props => [
  //       backdropPath,
  //       genres,
  //       id,
  //       overview,
  //       posterPath,
  //       status,
  //       voteAverage,
  //       voteCount,
  //       numberOfSeasons,
  //     ];
}
