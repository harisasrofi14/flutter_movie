import 'package:ditonton/data/models/episodes_model.dart';
import 'package:ditonton/domain/entities/tv_show_season.dart';
import 'package:equatable/equatable.dart';

class TvShowSeasons extends Equatable {
  TvShowSeasons(
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
        airDate: this.airDate.toString(),
        id: this.id,
        name: this.name,
        episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
        sId: this.sId,
        overview: this.overview,
        posterPath: this.posterPath.toString(),
        seasonNumber: this.seasonNumber);
  }

  @override
  List<Object?> get props =>
      [airDate, id, episodes, sId, name, overview, posterPath, seasonNumber];
}
