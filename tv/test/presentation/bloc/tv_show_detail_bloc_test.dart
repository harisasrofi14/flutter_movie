import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_show_detail.dart';
import 'package:tv/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv/utils/failure.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late GetTvShowDetail mockGetTvShowDetail;
  int tvShowId = 1;
  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(getTvShowDetail: mockGetTvShowDetail);
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tvShowId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailTvShow(id: tvShowId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailError(),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tvShowId));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, HashData] when get movie detail is successful',
    build: () {
      when(mockGetTvShowDetail.execute(tvShowId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailTvShow(id: tvShowId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailHasData(testTvShowDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tvShowId));
    },
  );
}
