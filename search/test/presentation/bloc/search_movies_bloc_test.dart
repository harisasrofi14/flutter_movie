import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late SearchMovies mockSearchMovies;
  late String query;
  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
    query = "Spiderman";
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when search movies is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(MovieOnQueryChanged(query)),
    expect: () =>
        [MovieSearchLoading(), const MovieSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HashData] when search movies is successful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(MovieOnQueryChanged(query)),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );
}
