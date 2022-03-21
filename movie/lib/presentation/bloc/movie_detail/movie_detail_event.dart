part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class OnGetDetailMovie extends MovieDetailEvent {
  final int id;

  const OnGetDetailMovie({required this.id});
}
