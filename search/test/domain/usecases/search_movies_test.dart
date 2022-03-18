import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies usecase;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  String query = "Spiderman";

  test('should get search result', () async {
    // arrange
    when(mockMovieRepository.searchMovies(query))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute(query);
    // assert
    expect(result, Right(testMovieList));
  });
}
