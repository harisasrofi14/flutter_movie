import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_season.dart';
import 'package:tv/presentation/bloc/tv_show_season/tv_show_season_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowSeason])
void main() {
  late TvShowSeasonBloc tvShowSeasonBloc;
  late GetTvShowSeason mockGetTvShowSeason;
  int tvShowId = 1;
  int tvShowSeason = 1;

  setUp(() {
    mockGetTvShowSeason = MockGetTvShowSeason();
    tvShowSeasonBloc = TvShowSeasonBloc(getTvShowSeason: mockGetTvShowSeason);
  });

  blocTest<TvShowSeasonBloc, TvShowSeasonState>(
    'Should emit [Loading, Error] when get tv show seasons is unsuccessful',
    build: () {
      when(mockGetTvShowSeason.execute(tvShowId, tvShowSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowSeasonBloc;
    },
    act: (bloc) => bloc
        .add(OnGetSeasonTvShow(tvShowId: tvShowId, seasonNumber: tvShowSeason)),
    expect: () => [
      TvShowSeasonLoading(),
      TvShowSeasonError(),
    ],
    verify: (bloc) {
      verify(mockGetTvShowSeason.execute(tvShowId, tvShowSeason));
    },
  );

  blocTest<TvShowSeasonBloc, TvShowSeasonState>(
    'Should emit [Loading, HashData] when get  tv show seasons is successful',
    build: () {
      when(mockGetTvShowSeason.execute(tvShowId, tvShowSeason))
          .thenAnswer((_) async => Right(testTvSeason));
      return tvShowSeasonBloc;
    },
    act: (bloc) => bloc
        .add(OnGetSeasonTvShow(tvShowId: tvShowId, seasonNumber: tvShowSeason)),
    expect: () => [
      TvShowSeasonLoading(),
      TvShowSeasonHasData(testTvSeason),
    ],
    verify: (bloc) {
      verify(mockGetTvShowSeason.execute(tvShowId, tvShowSeason));
    },
  );
}
