part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class MovieOnQueryChanged extends MovieSearchEvent {
  final String query;

  const MovieOnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
