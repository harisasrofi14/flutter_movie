import 'package:ditonton/data/models/episodes_model.dart';
import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = TvShowEpisode(
      airDate: 'airDate',
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 5.0,
      voteCount: 5);

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

  test('should be a subclass of Episode  entity', () async {
    final result = tEpisode.toEntity();
    expect(result, tEpisodeModel);
  });
}
