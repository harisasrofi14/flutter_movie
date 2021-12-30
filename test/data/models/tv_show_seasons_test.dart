import 'package:ditonton/data/models/episodes_model.dart';
import 'package:ditonton/data/models/tv_show_seasons.dart';
import 'package:ditonton/domain/entities/tv_show_season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisode = Episodes(
      airDate: 'airDate',
      id: 1,
      episodeNumber: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 5.0,
      voteCount: 5);


  final tSeasonModel = TvShowSeasons(
    sId: 'sId',
    airDate: 'airDate',
    episodes: [tEpisode],
    name: 'name',
    overview: 'overview',
    id: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tSeason = TvShowSeason(
    sId: 'sId',
    airDate: 'airDate',
    episodes: [tEpisode.toEntity()],
    name: 'name',
    overview: 'overview',
    id: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
