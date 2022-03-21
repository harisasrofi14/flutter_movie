part of 'tv_show_watch_list_bloc.dart';

abstract class TvShowWatchlistEvent {
  const TvShowWatchlistEvent();
}

class TvShowRemoveFromWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  const TvShowRemoveFromWatchlist(this.tvShowDetail);
}

class TvShowAddWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  const TvShowAddWatchlist(this.tvShowDetail);
}

class TvShowGetStatusWatchlist extends TvShowWatchlistEvent {
  final int tvShowId;

  const TvShowGetStatusWatchlist({required this.tvShowId});
}

class GetAllTvShowWatchlist extends TvShowWatchlistEvent {
  const GetAllTvShowWatchlist();
}
