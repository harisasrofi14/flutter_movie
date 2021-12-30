import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final String type;

  SearchPage({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  if (type == "movie") {
                    Provider.of<MovieSearchNotifier>(context, listen: false)
                        .fetchMovieSearch(query);
                  } else {
                    Provider.of<TvShowSearchNotifier>(context, listen: false)
                        .fetchTvShowSearch(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              type == "movie"
                  ? Consumer<MovieSearchNotifier>(
                      builder: (context, data, child) {
                        if (data.state == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.state == RequestState.Loaded) {
                          final result = data.searchResult;

                          return result.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final movie = data.searchResult[index];
                                      return MovieCard(movie);
                                    },
                                    itemCount: result.length,
                                  ),
                                )
                              : Center(
                                  child: Lottie.asset(
                                      'assets/json/not-found.json',
                                      repeat: false),
                                );
                        } else {
                          return Expanded(
                            child: Container(),
                          );
                        }
                      },
                    )
                  : Consumer<TvShowSearchNotifier>(
                      builder: (context, data, child) {
                        if (data.state == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.state == RequestState.Loaded) {
                          final result = data.searchResult;
                          return result.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final tvShow = data.searchResult[index];
                                      return TvShowCard(tvShow);
                                    },
                                    itemCount: result.length,
                                  ),
                                )
                              : Center(
                                  child: Lottie.asset(
                                      'assets/json/not-found.json',
                                      repeat: false),
                                );
                        } else {
                          return Expanded(
                            child: Container(),
                          );
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
