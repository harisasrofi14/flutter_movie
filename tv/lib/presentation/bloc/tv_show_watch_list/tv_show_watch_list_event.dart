part of 'tv_show_watch_list_bloc.dart';

abstract class TvShowWatchlistEvent extends Equatable {
  const TvShowWatchlistEvent();

  @override
  List<Object?> get props => [];
}

class TvShowRemoveFromWatchlist extends TvShowWatchlistEvent {
  @override
  List<Object?> get props => [tvShowDetail];

  final TvShowDetail tvShowDetail;

  const TvShowRemoveFromWatchlist(this.tvShowDetail);
}

class TvShowAddWatchlist extends TvShowWatchlistEvent {
  @override
  List<Object?> get props => [tvShowDetail];

  final TvShowDetail tvShowDetail;

  const TvShowAddWatchlist(this.tvShowDetail);
}

class TvShowGetStatusWatchlist extends TvShowWatchlistEvent {
  final int tvShowId;

  const TvShowGetStatusWatchlist({required this.tvShowId});

  @override
  List<Object?> get props => [tvShowId];
}

class GetAllTvShowWatchlist extends TvShowWatchlistEvent {
  const GetAllTvShowWatchlist();

}
