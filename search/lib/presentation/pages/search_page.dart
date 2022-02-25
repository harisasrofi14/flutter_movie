import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';
import 'package:tv/styles/text_styles.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final String type;

  const SearchPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  if (type == "movie_search") {
                    context
                        .read<MovieSearchBloc>()
                        .add(MovieOnQueryChanged(query));
                  } else {
                    context
                        .read<TvShowSearchBloc>()
                        .add(TvShowOnQueryChanged(query));
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              type == "movie_search"
                  ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
                      builder: (context, state) {
                        if (state is MovieSearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MovieSearchHasData) {
                          final result = state.result;
                          return Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final movie = result[index];
                                return MovieCard(movie);
                              },
                              itemCount: result.length,
                            ),
                          );
                        } else if (state is MovieSearchError) {
                          return Expanded(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        } else {
                          return Expanded(child: Container());
                        }
                      },
                    )
                  : BlocBuilder<TvShowSearchBloc, TvShowSearchState>(
                      builder: (context, state) {
                        if (state is TvShowSearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TvShowSearchHasData) {
                          final result = state.result;
                          return Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final tvShow = result[index];
                                return TvShowCard(tvShow);
                              },
                              itemCount: result.length,
                            ),
                          );
                        } else if (state is TvShowSearchError) {
                          return Expanded(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        } else {
                          return Expanded(child: Container());
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
