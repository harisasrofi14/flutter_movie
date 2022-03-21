import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';

class TvShowSeason extends Equatable {
  const TvShowSeason({
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
  final List<TvShowEpisodes> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [];
}
