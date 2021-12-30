


import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late Movie movie;
  setUp(() {
    movie = testMovie;
  });
  testWidgets('Card is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(movie),
        ),
      ),
    );

    final episodeFinder = find.byType(MovieCard);
    expect(episodeFinder, findsOneWidget);

    final titleFinder = find.text('Spider-Man');
    expect(titleFinder, findsOneWidget);
  });
}