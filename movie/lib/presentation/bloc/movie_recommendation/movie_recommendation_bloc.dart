import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({required this.getMovieRecommendations})
      : super(MovieRecommendationEmpty()) {
    on<OnGetRecommendationMovies>((event, emit) async {
      final int movieId = event.movieId;
      emit(MovieRecommendationLoading());
      final result = await getMovieRecommendations.execute(movieId);
      result.fold((failure) {
        emit(MovieRecommendationError());
      }, (result) => emit(MovieRecommendationHasData(result)));
    });
  }
}
