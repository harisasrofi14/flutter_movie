import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';

class Episodes extends Equatable {
  const Episodes(
      {required this.airDate,
      required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.seasonNumber,
      required this.stillPath,
      required this.voteAverage,
      required this.voteCount});

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];

  TvShowEpisodes toEntity() {
    return TvShowEpisodes(
        airDate: airDate,
        id: id,
        name: name,
        overview: overview,
        seasonNumber: seasonNumber,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }
}
