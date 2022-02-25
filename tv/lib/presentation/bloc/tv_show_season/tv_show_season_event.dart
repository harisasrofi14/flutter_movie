part of 'tv_show_season_bloc.dart';

abstract class TvShowSeasonEvent extends Equatable {
  const TvShowSeasonEvent();

  List<Object?> get props => [];
}

class OnGetSeasonTvShow extends TvShowSeasonEvent {
  @override
  List<Object?> get props => [tvShowId];

  final int tvShowId;
  final int seasonNumber;

  OnGetSeasonTvShow({required this.tvShowId, required this.seasonNumber});
}
