part of 'tv_show_recommendation_bloc.dart';

abstract class TvShowRecommendationState extends Equatable {
  const TvShowRecommendationState();

  @override
  List<Object?> get props => [];
}

class TvShowRecommendationEmpty extends TvShowRecommendationState {}

class TvShowRecommendationLoading extends TvShowRecommendationState {}

class TvShowRecommendationError extends TvShowRecommendationState {}

class TvShowRecommendationHasData extends TvShowRecommendationState {
  final List<TvShow> result;

  const TvShowRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
