import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show';

  @override
  _TvShowPageState createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchNowPlayingTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tv Show"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Airing Today',
                  style: kHeading6,
                ),
                Consumer<TvShowListNotifier>(builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvShowList(data.nowPlayingTvShow);
                  } else {
                    return Text('Failed');
                  }
                }),
                Text(
                  'Popular',
                  style: kHeading6,
                ),
                Consumer<TvShowListNotifier>(builder: (context, data, child) {
                  final state = data.popularTvShowState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvShowList(data.popularTvShow);
                  } else {
                    return Text('failed');
                  }
                }),
                Text(
                  'Top Rated',
                  style: kHeading6,
                ),
                Consumer<TvShowListNotifier>(builder: (context, data, child) {
                  final state = data.topRatedTvShowState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvShowList(data.topRatedTvShow);
                  } else {
                    return Text('failed');
                  }
                }),
              ],
            ),
          ),
        ));
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   MovieDetailPage.ROUTE_NAME,
                //   arguments: movie.id,
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
