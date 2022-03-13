import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/episodes_model.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';

void main() {
  final tEpisodeModel = TvShowEpisodes(
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
