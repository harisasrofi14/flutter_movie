import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:equatable/equatable.dart';

class TvShowSeason extends Equatable {
  TvShowSeason({
    required this.sId,
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? sId;
  final String? airDate;
  final List<TvShowEpisode> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props =>
      [sId, airDate, episodes, name, overview, id, posterPath, seasonNumber];
}
