import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvShowNotifier>(context, listen: false)
          .fetchWatchlistTvShow();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Movie",
              ),
              Tab(
                text: "Tv Show",
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<WatchlistMovieNotifier>(
                  builder: (context, data, child) {
                    if (data.watchlistState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.watchlistState == RequestState.Loaded) {
                      return data.watchlistMovies.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = data.watchlistMovies[index];
                                return MovieCard(movie);
                              },
                              itemCount: data.watchlistMovies.length,
                            )
                          : Center(
                              child: Text("Empty"),
                            );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(data.message),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Consumer<WatchlistTvShowNotifier>(
                    builder: (context, data, child) {
                      if (data.watchlistState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.watchlistState == RequestState.Loaded) {
                        return data.watchlistTvShows.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final tvShow = data.watchlistTvShows[index];
                                  return TvShowCard(tvShow);
                                },
                                itemCount: data.watchlistTvShows.length,
                              )
                            : Center(
                                child: Text("Empty"),
                              );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text(data.message),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
