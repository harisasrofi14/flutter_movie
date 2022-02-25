part of 'tv_show_watch_list_bloc.dart';

abstract class TvShowWatchlistState extends Equatable {
  const TvShowWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvShowRemoveWatchlistEmpty extends TvShowWatchlistState {}

class TvShowRemoveWatchlist extends TvShowWatchlistState {
  final TvShowDetail tvShowDetail;

  const TvShowRemoveWatchlist({required this.tvShowDetail});
}

class TvShowRemoveWatchlistError extends TvShowWatchlistState {
  final String error;

  const TvShowRemoveWatchlistError({required this.error});
}

class TvShowRemoveWatchlistSuccess extends TvShowWatchlistState {
  final String message;

  const TvShowRemoveWatchlistSuccess({required this.message});
}

class TvShowAddWatchlistError extends TvShowWatchlistState {
  final String error;

  const TvShowAddWatchlistError({required this.error});
}

class TvShowAddWatchlistSuccess extends TvShowWatchlistState {
  final String message;

  const TvShowAddWatchlistSuccess({required this.message});
}

class TvShowLoadWatchlistStatus extends TvShowWatchlistState {
  final bool isWatchList;

  const TvShowLoadWatchlistStatus({required this.isWatchList});

  @override
  List<Object?> get props => [isWatchList];
}

class TvShowGetAllWatchlistSuccess extends TvShowWatchlistState {
  final List<TvShow> tvShows;

  const TvShowGetAllWatchlistSuccess({required this.tvShows});

  @override
  List<Object?> get props => [tvShows];
}

class TvShowGetAllWatchlistError extends TvShowWatchlistState {
  final String error;

  const TvShowGetAllWatchlistError({required this.error});
}

class TvShowGetAllWatchlistLoading extends TvShowWatchlistState {}
