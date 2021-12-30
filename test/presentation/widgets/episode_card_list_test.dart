import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvShowEpisode episode;
  setUp(() {
    episode = testEpisode;
  });
  testWidgets('Card is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EpisodeCard(episode),
        ),
      ),
    );

    final episodeFinder = find.byType(EpisodeCard);
    expect(episodeFinder, findsOneWidget);

    final titleFinder = find.text('name');
    expect(titleFinder, findsOneWidget);
  });
}
