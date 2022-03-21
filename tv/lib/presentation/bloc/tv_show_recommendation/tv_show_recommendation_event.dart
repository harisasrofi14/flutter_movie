part of 'tv_show_recommendation_bloc.dart';

abstract class TvShowRecommendationEvent {
  const TvShowRecommendationEvent();
}

class OnGetRecommendationTvShow extends TvShowRecommendationEvent {
  final int tvShowId;

  const OnGetRecommendationTvShow({required this.tvShowId});
}
