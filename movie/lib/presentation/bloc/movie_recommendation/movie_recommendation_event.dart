part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  List<Object?> get props => [];
}

class OnGetRecommendationMovies extends MovieRecommendationEvent {
  @override
  List<Object?> get props => [movieId];

  final int movieId;

  OnGetRecommendationMovies({required this.movieId});
}
