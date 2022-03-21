part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent {
  const MovieSearchEvent();
}

class MovieOnQueryChanged extends MovieSearchEvent {
  final String query;

  const MovieOnQueryChanged(this.query);
}
