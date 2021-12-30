import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season.dart';
import 'package:ditonton/presentation/provider/tv_show_season_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_season_notifier_test.mocks.dart';

@GenerateMocks([GetTvShowSeason])
void main() {
  late MockGetTvShowSeason mockGetTvShowSeason;
  late TvShowSeasonNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowSeason = MockGetTvShowSeason();
    notifier = TvShowSeasonNotifier(mockGetTvShowSeason)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvShowSeason.execute(1, 1))
        .thenAnswer((_) async => Right(testTvSeason));
    // act
    notifier.fetchTvShowSeason(1, 1);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvShowSeason.execute(1, 1))
        .thenAnswer((_) async => Right(testTvSeason));
    // act
    await notifier.fetchTvShowSeason(1, 1);

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShowSeason, testTvSeason);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvShowSeason.execute(1, 1))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvShowSeason(1, 1);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
