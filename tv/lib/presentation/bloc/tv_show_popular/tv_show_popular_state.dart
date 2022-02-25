part of 'tv_show_popular_bloc.dart';

abstract class TvShowPopularState extends Equatable {
  const TvShowPopularState();

  @override
  List<Object?> get props => [];
}

class TvShowPopularEmpty extends TvShowPopularState {}

class TvShowPopularLoading extends TvShowPopularState {}

class TvShowPopularError extends TvShowPopularState {}

class TvShowPopularHasData extends TvShowPopularState {
  final List<TvShow> result;

  const TvShowPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
