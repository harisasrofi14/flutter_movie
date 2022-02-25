import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_watch_list/movie_watch_list_bloc.dart';

import '../../movie.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final int id;

  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieDetailBloc>(context)
          .add(OnGetDetailMovie(id: widget.id));
      BlocProvider.of<MovieWatchlistBloc>(context)
          .add(GetStatusWatchlist(movieId: widget.id));
      BlocProvider.of<MovieRecommendationBloc>(context)
          .add(OnGetRecommendationMovies(movieId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailState movieDetailState = context.watch<MovieDetailBloc>().state;
    MovieRecommendationState movieRecommendationState =
        context.watch<MovieRecommendationBloc>().state;
    return Scaffold(
        body: movieDetailState is MovieDetailLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : movieDetailState is MovieDetailHasData
                ? SafeArea(
                    child: DetailContent(
                      movieDetailState.result,
                      // isAddedToWatchlist,
                      movieRecommendationState is MovieRecommendationHasData
                          ? movieRecommendationState.result
                          : List.empty(),
                    ),
                  )
                : const Text('Failed'));
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;

  const DetailContent(this.movie, this.recommendations);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _showGenres(movie.genres),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _showDuration(movie.runtime),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RatingBarIndicator(
                                            rating: movie.voteAverage / 2,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: kMikadoYellow,
                                            ),
                                            itemSize: 24,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${movie.voteAverage}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                WatchlistButton(
                                  movie: movie,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          MovieDetailPage.ROUTE_NAME,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<MovieGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class WatchlistButton extends StatelessWidget {
  final MovieDetail movie;

  const WatchlistButton({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieWatchlistBloc, MovieWatchlistState>(
        builder: (BuildContext context, state) {
      bool isAddedToWatchlist =
          context.select<MovieWatchlistBloc, bool>((movieWatchlistBloc) {
        return (movieWatchlistBloc.state is MovieLoadWatchlistStatus)
            ? (movieWatchlistBloc.state as MovieLoadWatchlistStatus).isWatchList
            : false;
      });

      return ElevatedButton(
        onPressed: () async {
          if (isAddedToWatchlist) {
            BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
              ..add(RemoveFromWatchlist(movie));
          } else {
            BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
              ..add(AddWatchlist(movie));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isAddedToWatchlist
                ? const Icon(Icons.check)
                : const Icon(Icons.add),
            const Text('Watchlist'),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is MovieAddWatchlistSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2)));
      } else if (state is MovieAddWatchlistError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text(
                state.error,
              ));
            });
      } else if (state is MovieRemoveWatchlistSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2)));
      } else if (state is MovieRemoveWatchlistError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text(
                state.error,
              ));
            });
      }
    });
  }
}
