import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/presentation/bloc/tv_show_now_playing/tv_show_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_popular/tv_show_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_top_rated/tv_show_top_rated_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_show_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv/presentation/pages/tv_show_detail_page.dart';

import '../../tv.dart';

class TvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show';

  const TvShowPage({Key? key}) : super(key: key);

  @override
  _TvShowPageState createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvShowNowPlayingBloc>(context)
          .add(OnGetNowPlayingTvShow());
      BlocProvider.of<TvShowTopRatedBloc>(context).add(OnGetTopRatedTvShow());
      BlocProvider.of<TvShowPopularBloc>(context).add(OnGetPopularTvShow());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tv Show"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                  arguments: "tvShow");
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Now Playing',
                  style: kHeading6,
                ),
                BlocBuilder<TvShowNowPlayingBloc, TvShowNowPlayingState>(
                    builder: (context, state) {
                  if (state is TvShowNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowNowPlayingHasData) {
                    final data = state.result;
                    return TvShowList(data);
                  } else {
                    return const Text('Failed');
                  }
                }),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(
                      context, PopularTvShowPage.ROUTE_NAME),
                ),
                BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
                    builder: (context, state) {
                  if (state is TvShowPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowPopularHasData) {
                    final data = state.result;
                    return TvShowList(data);
                  } else {
                    return const Text('Failed');
                  }
                }),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(
                      context, TopRatedTvShowsPage.ROUTE_NAME),
                ),
                BlocBuilder<TvShowTopRatedBloc, TvShowTopRatedState>(
                    builder: (context, state) {
                  if (state is TvShowTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvShowTopRatedHasData) {
                    final data = state.result;
                    return TvShowList(data);
                  } else {
                    return const Text('Failed');
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList(this.tvShows, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
