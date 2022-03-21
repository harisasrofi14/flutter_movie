part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent {
  const MovieRecommendationEvent();
}

class OnGetRecommendationMovies extends MovieRecommendationEvent {
  final int movieId;

  const OnGetRecommendationMovies({required this.movieId});
}
