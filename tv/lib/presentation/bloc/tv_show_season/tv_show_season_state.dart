part of 'tv_show_season_bloc.dart';

abstract class TvShowSeasonState extends Equatable {
  const TvShowSeasonState();

  @override
  List<Object?> get props => [];
}

class TvShowSeasonEmpty extends TvShowSeasonState {}

class TvShowSeasonLoading extends TvShowSeasonState {}

class TvShowSeasonError extends TvShowSeasonState {}

class TvShowSeasonHasData extends TvShowSeasonState {
  final TvShowSeason result;

  const TvShowSeasonHasData(this.result);

  @override
  List<Object> get props => [result];
}
