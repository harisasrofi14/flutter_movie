import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv_show.dart';
import 'package:tv/presentation/bloc/tv_show_popular/tv_show_popular_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late TvShowPopularBloc tvShowPopularBloc;
  late GetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    tvShowPopularBloc =
        TvShowPopularBloc(getPopularTvShows: mockGetPopularTvShows);
  });

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'Should emit [Loading, Error] when get popular tv show is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(OnGetPopularTvShow()),
    expect: () => [
      TvShowPopularLoading(),
      TvShowPopularError(),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'Should emit [Loading, HashData] when get popular tv show is successful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(OnGetPopularTvShow()),
    expect: () => [
      TvShowPopularLoading(),
      TvShowPopularHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}
