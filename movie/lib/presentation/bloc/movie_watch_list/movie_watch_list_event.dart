part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  List<Object?> get props => [];
}

class RemoveFromWatchlist extends MovieWatchlistEvent {
  @override
  List<Object?> get props => [movie];

  final MovieDetail movie;

  const RemoveFromWatchlist(this.movie);
}

class AddWatchlist extends MovieWatchlistEvent {
  @override
  List<Object?> get props => [movie];

  final MovieDetail movie;

  const AddWatchlist(this.movie);
}

class GetStatusWatchlist extends MovieWatchlistEvent {
  final int movieId;

  const GetStatusWatchlist({required this.movieId});

  List<Object?> get props => [movieId];
}

class GetAllMovieWatchlist extends MovieWatchlistEvent {
  const GetAllMovieWatchlist();

  @override
  List<Object?> get props => super.props;
}
