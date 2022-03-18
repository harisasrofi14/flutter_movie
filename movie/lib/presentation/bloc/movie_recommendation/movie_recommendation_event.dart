part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();
}

class OnGetRecommendationMovies extends MovieRecommendationEvent {
  @override
  List<Object?> get props => [movieId];

  final int movieId;

  const OnGetRecommendationMovies({required this.movieId});
}
