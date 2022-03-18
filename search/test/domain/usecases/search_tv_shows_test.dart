import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockTvShowRepository mockTvShowRepository;
  late SearchTvShows usecase;
  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  String query = "Spiderman";

  test('should get search result', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(query))
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute(query);
    // assert
    expect(result, Right(testTvShowList));
  });
}
