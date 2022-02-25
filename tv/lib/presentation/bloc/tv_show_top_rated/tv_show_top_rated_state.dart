part of 'tv_show_top_rated_bloc.dart';

abstract class TvShowTopRatedState extends Equatable {
  const TvShowTopRatedState();

  @override
  List<Object?> get props => [];
}

class TvShowTopRatedEmpty extends TvShowTopRatedState {}

class TvShowTopRatedLoading extends TvShowTopRatedState {}

class TvShowTopRatedError extends TvShowTopRatedState {}

class TvShowTopRatedHasData extends TvShowTopRatedState {
  final List<TvShow> result;

  const TvShowTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
