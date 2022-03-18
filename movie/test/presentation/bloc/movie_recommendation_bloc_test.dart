import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late GetMovieRecommendations mockGetMovieRecommendation;
  int id = 1;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
        getMovieRecommendations: mockGetMovieRecommendation);
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnGetRecommendationMovies(movieId: id)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError(),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(id));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, HashData] when get recommendation is successful',
    build: () {
      when(mockGetMovieRecommendation.execute(id))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnGetRecommendationMovies(movieId: id)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(id));
    },
  );
}
