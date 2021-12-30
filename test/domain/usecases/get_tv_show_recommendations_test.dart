import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowRecommendations(mockTvShowRepository);
  });

  final tId = 1;
  final tTvShows = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTvShowRepository.getTvShowsRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tTvShows));
  });
}
