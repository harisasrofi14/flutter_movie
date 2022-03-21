part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchlistEvent {
  const MovieWatchlistEvent();
}

class RemoveFromWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveFromWatchlist(this.movie);
}

class AddWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  const AddWatchlist(this.movie);
}

class GetStatusWatchlist extends MovieWatchlistEvent {
  final int movieId;

  const GetStatusWatchlist({required this.movieId});
}

class GetAllMovieWatchlist extends MovieWatchlistEvent {
  const GetAllMovieWatchlist();
}
