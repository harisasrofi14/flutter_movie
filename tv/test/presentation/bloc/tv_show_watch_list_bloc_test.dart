import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_show.dart';
import 'package:tv/presentation/bloc/tv_show_watch_list/tv_show_watch_list_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_watch_list_bloc_test.mocks.dart';

@GenerateMocks([
  RemoveWatchlistTvShow,
  SaveWatchlistTvShow,
  GetTvShowWatchListStatus,
  GetWatchlistTvShows
])
void main() {
  late TvShowWatchlistBloc tvShowWatchlistBloc;
  late RemoveWatchlistTvShow mockRemoveWatchlistTvShow;
  late SaveWatchlistTvShow mockSaveWatchlistTvShow;
  late GetWatchlistTvShows mockGetWatchlistTvShows;
  late GetTvShowWatchListStatus mockGetTvShowWatchListStatus;
  int tvShowId = 1;
  setUp(() {
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockGetTvShowWatchListStatus = MockGetTvShowWatchListStatus();
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();

    tvShowWatchlistBloc = TvShowWatchlistBloc(
        removeWatchlistTvShow: mockRemoveWatchlistTvShow,
        saveWatchlistTvShow: mockSaveWatchlistTvShow,
        getWatchlistTvShows: mockGetWatchlistTvShows,
        getTvShowWatchListStatus: mockGetTvShowWatchListStatus);
  });

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit [Error] when save tv show to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to access database')));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvShowAddWatchlist(testTvShowDetail)),
    expect: () => [
      const TvShowAddWatchlistError(error: 'Failed to access database'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit success when save tv show to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetTvShowWatchListStatus.execute(tvShowId))
          .thenAnswer((_) async => true);
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvShowAddWatchlist(testTvShowDetail)),
    expect: () => [
      const TvShowAddWatchlistSuccess(message: 'Added to Watchlist'),
      const TvShowLoadWatchlistStatus(isWatchList: true)
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit [Error] when remove tv show from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to access database')));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvShowRemoveFromWatchlist(testTvShowDetail)),
    expect: () => [
      const TvShowRemoveWatchlistError(error: 'Failed to access database'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit success when remove tv show from watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetTvShowWatchListStatus.execute(tvShowId))
          .thenAnswer((_) async => false);
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvShowRemoveFromWatchlist(testTvShowDetail)),
    expect: () => [
      const TvShowRemoveWatchlistSuccess(message: 'Removed from Watchlist'),
      const TvShowLoadWatchlistStatus(isWatchList: false)
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit success when get all watchlist is successful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));

      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetAllTvShowWatchlist()),
    expect: () => [
      TvShowGetAllWatchlistLoading(),
      TvShowGetAllWatchlistSuccess(tvShows: testTvShowList)
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
