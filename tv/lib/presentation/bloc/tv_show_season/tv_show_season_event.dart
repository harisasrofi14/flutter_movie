part of 'tv_show_season_bloc.dart';

abstract class TvShowSeasonEvent {
  const TvShowSeasonEvent();
}

class OnGetSeasonTvShow extends TvShowSeasonEvent {
  final int tvShowId;
  final int seasonNumber;

  const OnGetSeasonTvShow({required this.tvShowId, required this.seasonNumber});
}
