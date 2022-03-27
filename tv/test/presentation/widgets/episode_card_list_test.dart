

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';
import 'package:tv/presentation/widgets/episode_card_list.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';

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
          body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                return EpisodeCard(episodes[index]);
              }),
        ),
      ),
    );

    final episodeFinder = find.byType(EpisodeCard);
    expect(episodeFinder, findsOneWidget);

  });
}
