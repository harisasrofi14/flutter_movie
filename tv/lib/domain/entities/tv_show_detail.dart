import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/genre.dart';

class TvShowDetail extends Equatable {
  const TvShowDetail({
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
  final List<TvShowGenre> genres;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;

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
        numberOfSeasons
      ];
}
