part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieRemoveWatchlistEmpty extends MovieWatchlistState {}

class MovieRemoveWatchlist extends MovieWatchlistState {
  final MovieDetail movie;

  const MovieRemoveWatchlist({required this.movie});
}

class MovieRemoveWatchlistError extends MovieWatchlistState {
  final String error;

  const MovieRemoveWatchlistError({required this.error});
}

class MovieRemoveWatchlistSuccess extends MovieWatchlistState {
  final String message;

  const MovieRemoveWatchlistSuccess({required this.message});
}

class MovieAddWatchlistError extends MovieWatchlistState {
  final String error;

  const MovieAddWatchlistError({required this.error});
}

class MovieAddWatchlistSuccess extends MovieWatchlistState {
  final String message;

  const MovieAddWatchlistSuccess({required this.message});
}

class MovieLoadWatchlistStatus extends MovieWatchlistState {
  final bool isWatchList;

  const MovieLoadWatchlistStatus({required this.isWatchList});

  @override
  List<Object?> get props => [isWatchList];
}

class MovieGetAllWatchlistSuccess extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieGetAllWatchlistSuccess({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class MovieGetAllWatchlistError extends MovieWatchlistState {
  final String error;

  const MovieGetAllWatchlistError({required this.error});
}

class MovieGetAllWatchlistLoading extends MovieWatchlistState {
  const MovieGetAllWatchlistLoading();
}
