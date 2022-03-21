import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_show.dart';
import 'package:tv/presentation/bloc/tv_show_top_rated/tv_show_top_rated_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TvShowTopRatedBloc tvShowTopRatedBloc;
  late GetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    tvShowTopRatedBloc =
        TvShowTopRatedBloc(getTopRatedTvShows: mockGetTopRatedTvShows);
  });

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'Should emit [Loading, Error] when get top rated tv show is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedTvShow()),
    expect: () => [
      TvShowTopRatedLoading(),
      TvShowTopRatedError(),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'Should emit [Loading, HashData] when get top rated tv show is successful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedTvShow()),
    expect: () => [
      TvShowTopRatedLoading(),
      TvShowTopRatedHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
