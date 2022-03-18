part of 'tv_show_now_playing_bloc.dart';

abstract class TvShowNowPlayingEvent {
  const TvShowNowPlayingEvent();
}

class OnGetNowPlayingTvShow extends TvShowNowPlayingEvent {}
