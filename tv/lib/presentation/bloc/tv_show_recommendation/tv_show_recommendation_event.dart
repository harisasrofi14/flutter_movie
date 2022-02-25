part of 'tv_show_recommendation_bloc.dart';

abstract class TvShowRecommendationEvent extends Equatable {
  const TvShowRecommendationEvent();

  List<Object?> get props => [];
}

class OnGetRecommendationTvShow extends TvShowRecommendationEvent {
  @override
  List<Object?> get props => [tvShowId];

  final int tvShowId;

  OnGetRecommendationTvShow({required this.tvShowId});
}
