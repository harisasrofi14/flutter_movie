


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';
import 'package:tv/presentation/pages/tv_show_episode_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late List<TvShowEpisodes> episodes;
  setUp(() {
    episodes = testTvSeason.episodes;
  });
  testWidgets('Card is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvShowEpisodeDetailPage(episodes: episodes[0])
        ),
      ),
    );

    final episodeFinder = find.byType(TvShowEpisodeDetailPage);
    expect(episodeFinder, findsOneWidget);

  });
}