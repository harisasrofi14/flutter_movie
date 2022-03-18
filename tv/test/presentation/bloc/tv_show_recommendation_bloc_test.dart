import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv/presentation/bloc/tv_show_recommendation/tv_show_recommendation_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowRecommendations])
void main() {
  late TvShowRecommendationBloc tvShowPopularBloc;
  late GetTvShowRecommendations mockGetTvShowRecommendations;
  int tvShowId = 1;
  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowPopularBloc = TvShowRecommendationBloc(
        getTvShowRecommendations: mockGetTvShowRecommendations);
  });

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'Should emit [Loading, Error] when get tv show recommendations is unsuccessful',
    build: () {
      when(mockGetTvShowRecommendations.execute(tvShowId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(OnGetRecommendationTvShow(tvShowId: tvShowId)),
    expect: () => [
      TvShowRecommendationLoading(),
      TvShowRecommendationError(),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tvShowId));
    },
  );

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'Should emit [Loading, HashData] when get  tv show recommendation is successful',
    build: () {
      when(mockGetTvShowRecommendations.execute(tvShowId))
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(OnGetRecommendationTvShow(tvShowId: tvShowId)),
    expect: () => [
      TvShowRecommendationLoading(),
      TvShowRecommendationHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tvShowId));
    },
  );
}
