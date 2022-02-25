import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episodes_model.dart';
import 'package:tv/domain/entities/tv_show_season.dart';

class TvShowSeasons extends Equatable {
  const TvShowSeasons(
      {required this.sId,
      required this.airDate,
      required this.episodes,
      required this.name,
      required this.overview,
      required this.id,
      required this.posterPath,
      required this.seasonNumber});

  final String? sId;
  final String? airDate;
  final List<Episodes> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;

  factory TvShowSeasons.fromJson(Map<String, dynamic> json) => TvShowSeasons(
        sId: json['_id'],
        airDate: json['air_date'],
        episodes: List<Episodes>.from(
            json["episodes"].map((x) => Episodes.fromJson(x))),
        name: json['name'],
        overview: json['overview'],
        id: json['id'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );

  TvShowSeason toEntity() {
    return TvShowSeason(
        airDate: airDate.toString(),
        id: id,
        name: name,
        episodes: episodes.map((episode) => episode.toEntity()).toList(),
        sId: sId,
        overview: overview,
        posterPath: posterPath.toString(),
        seasonNumber: seasonNumber);
  }

  @override
  List<Object?> get props =>
      [airDate, id, episodes, sId, name, overview, posterPath, seasonNumber];
}
