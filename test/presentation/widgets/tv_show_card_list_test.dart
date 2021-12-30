import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvShow tvShow;
  setUp(() {
    tvShow = testTvShow;
  });
  testWidgets('Card is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvShowCard(tvShow),
        ),
      ),
    );

    final tvShowFinder = find.byType(TvShowCard);
    expect(tvShowFinder, findsOneWidget);

    final titleFinder = find.text('name');
    expect(titleFinder, findsOneWidget);
  });
}
