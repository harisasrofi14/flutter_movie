import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:equatable/equatable.dart';

class Episodes extends Equatable {
  Episodes(
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

  TvShowEpisode toEntity() {
    return TvShowEpisode(
        airDate: this.airDate,
        id: this.id,
        name: this.name,
        overview: this.overview,
        seasonNumber: this.seasonNumber,
        stillPath: this.stillPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }
}
