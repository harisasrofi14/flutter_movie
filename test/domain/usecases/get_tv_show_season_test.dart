import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowSeason useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowSeason(mockTvShowRepository);
  });

  final tId = 1;
  final tNo = 1;

  test('should get list of tv show season from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowSeason(tId, tNo))
        .thenAnswer((_) async => Right(testTvSeason));
    // act
    final result = await useCase.execute(tId, tNo);
    // assert
    expect(result, Right(testTvSeason));
  });
}
