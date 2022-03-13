import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_show.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTopRatedTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTvShowRepository.getTopRatedTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}
