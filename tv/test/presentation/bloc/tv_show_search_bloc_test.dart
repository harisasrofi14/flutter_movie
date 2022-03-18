import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tv_shows.dart';
import 'package:tv/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchBloc tvShowSearchBloc;
  late SearchTvShows mockSearchTvShows;
  String query = "spiderman";

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    tvShowSearchBloc = TvShowSearchBloc(searchTvShows: mockSearchTvShows);
  });

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, Error] when search tv show is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowSearchBloc;
    },
    act: (bloc) => bloc.add(TvShowOnQueryChanged(query)),
    expect: () => [
      TvShowSearchLoading(),
      const TvShowSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(query));
    },
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, HashData] when search tv show is successful',
    build: () {
      when(mockSearchTvShows.execute(query))
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowSearchBloc;
    },
    act: (bloc) => bloc.add(TvShowOnQueryChanged(query)),
    expect: () => [
      TvShowSearchLoading(),
      TvShowSearchHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(query));
    },
  );
}
