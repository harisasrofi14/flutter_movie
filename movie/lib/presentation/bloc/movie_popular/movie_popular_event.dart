part of 'movie_popular_bloc.dart';

abstract class MoviePopularEvent {
  const MoviePopularEvent();
}

class OnGetPopularMovies extends MoviePopularEvent {}
