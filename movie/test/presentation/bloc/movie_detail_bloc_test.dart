import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late GetMovieDetail mockGetMovieDetail;
  int id = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get detail movie is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailMovie(id: id)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError(),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HashData] when get popular movies is successful',
    build: () {
      when(mockGetMovieDetail.execute(id))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailMovie(id: id)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );
}
