

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_watch_list/movie_watch_list_bloc.dart';
import 'package:movie/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watch_list_bloc_test.mocks.dart';

@GenerateMocks([RemoveWatchlist,SaveWatchlist,GetWatchlistMovies,GetWatchListStatus])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late RemoveWatchlist mockRemoveWatchlist;
  late SaveWatchlist mockSaveWatchlist;
  late GetWatchlistMovies mockGetWatchlistMovies;
  late GetWatchListStatus mockGetWatchlistStatus;

  int id = 1;

  setUp(() {
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlist = MockSaveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(removeWatchlist: mockRemoveWatchlist,
        getWatchlistStatus: mockGetWatchlistStatus,
        getWatchlistMovies: mockGetWatchlistMovies,
        saveWatchlist: mockSaveWatchlist);
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Error] when save movie to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed to access database')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    expect: () => [
      const MovieAddWatchlistError(error: 'Failed to access database'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit success when save movie to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(id)).thenAnswer((_) async =>  true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    expect: () => [
      const MovieAddWatchlistSuccess(message: 'Added to Watchlist'),
      const MovieLoadWatchlistStatus(isWatchList: true)
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Error] when remove movie from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed to access database')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    expect: () => [
      const MovieRemoveWatchlistError(error: 'Failed to access database'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit success when remove movie from watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchlistStatus.execute(id)).thenAnswer((_) async =>  false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    expect: () => [
      const MovieRemoveWatchlistSuccess(message: 'Removed from Watchlist'),
      const MovieLoadWatchlistStatus(isWatchList: false)
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );


  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit success when get all watchlist is successful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetAllMovieWatchlist()),
    expect: () => [
      const MovieGetAllWatchlistLoading(),
      MovieGetAllWatchlistSuccess(movies: testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
