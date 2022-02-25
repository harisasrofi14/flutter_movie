part of 'tv_show_now_playing_bloc.dart';

abstract class TvShowNowPlayingState extends Equatable {
  const TvShowNowPlayingState();

  @override
  List<Object?> get props => [];
}

class TvShowNowPlayingEmpty extends TvShowNowPlayingState {}

class TvShowNowPlayingLoading extends TvShowNowPlayingState {}

class TvShowNowPlayingError extends TvShowNowPlayingState {}

class TvShowNowPlayingHasData extends TvShowNowPlayingState {
  final List<TvShow> result;

  const TvShowNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
