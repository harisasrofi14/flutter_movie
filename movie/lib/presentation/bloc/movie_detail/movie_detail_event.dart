part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class OnGetDetailMovie extends MovieDetailEvent {
  final int id;

  const OnGetDetailMovie({required this.id});

  @override
  List<Object?> get props => [];
}
