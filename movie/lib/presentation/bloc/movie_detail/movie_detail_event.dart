


part of 'movie_detail_bloc.dart';


abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  List<Object?> get props => [];
}

class OnGetDetailMovie extends MovieDetailEvent {

  final int id;

  OnGetDetailMovie({required this.id});

  @override
  List<Object?> get props => [];
}