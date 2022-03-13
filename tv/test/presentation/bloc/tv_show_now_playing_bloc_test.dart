import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_show.dart';
import 'package:tv/presentation/bloc/tv_show_now_playing/tv_show_now_playing_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late TvShowNowPlayingBloc tvShowNowPlayingBloc;
  late GetNowPlayingTvShows mockGetNowPlayingTvShows;

  setUp(() {
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    tvShowNowPlayingBloc =
        TvShowNowPlayingBloc(getNowPlayingTvShows: mockGetNowPlayingTvShows);
  });

  blocTest<TvShowNowPlayingBloc, TvShowNowPlayingState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnGetNowPlayingTvShow()),
    expect: () => [
      TvShowNowPlayingLoading(),
      TvShowNowPlayingError(),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );

  blocTest<TvShowNowPlayingBloc, TvShowNowPlayingState>(
    'Should emit [Loading, HashData] when get popular movies is successful',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnGetNowPlayingTvShow()),
    expect: () => [
      TvShowNowPlayingLoading(),
      TvShowNowPlayingHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );
}
