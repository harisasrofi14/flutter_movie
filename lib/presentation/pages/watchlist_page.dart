
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_watch_list/movie_watch_list_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/bloc/tv_show_watch_list/tv_show_watch_list_bloc.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';
import 'package:tv/utils/utils.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context)..add(GetAllMovieWatchlist());
      BlocProvider.of<TvShowWatchlistBloc>(context)
        ..add(GetAllTvShowWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context)..add(GetAllMovieWatchlist());
    BlocProvider.of<TvShowWatchlistBloc>(context)
      ..add(GetAllTvShowWatchlist());
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
                child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                    builder: (context, state) {
                  if (state is MovieGetAllWatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MovieGetAllWatchlistError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is MovieGetAllWatchlistSuccess) {
                    final data = state.movies;
                    return data.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = data[index];
                              return MovieCard(movie);
                            },
                            itemCount: data.length,
                          )
                        : Center(
                            child: Text("Empty"),
                          );
                  } else {
                    return Text('Failed');
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: BlocBuilder<TvShowWatchlistBloc, TvShowWatchlistState>(
                      builder: (context, state) {
                    if (state is TvShowGetAllWatchlistLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is TvShowGetAllWatchlistError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is TvShowGetAllWatchlistSuccess) {
                      final data = state.tvShows;
                      return data.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final tvShow = data[index];
                                return TvShowCard(tvShow);
                              },
                              itemCount: data.length,
                            )
                          : Center(
                              child: Text("Empty"),
                            );
                    } else {
                      return Text('Failed');
                    }
                  }),
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
