



import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetWatchlistTvShows(mockTvShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}