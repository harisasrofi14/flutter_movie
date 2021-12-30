import 'package:equatable/equatable.dart';

class TvShowEpisode extends Equatable {
  TvShowEpisode(
      {required this.airDate,
      required this.id,
      required this.name,
      required this.overview,
      required this.seasonNumber,
      required this.stillPath,
      required this.voteAverage,
      required this.voteCount});

  final String airDate;
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        airDate,
        id,
        name,
        overview,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount
      ];
}
