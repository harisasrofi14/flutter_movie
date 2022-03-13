import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_recommendation/tv_show_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_season/tv_show_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_watch_list/tv_show_watch_list_bloc.dart';
import 'package:tv/presentation/widgets/episode_card_list.dart';

import '../../tv.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv_show';

  final int id;

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvShowDetailBloc>(context)
        .add(OnGetDetailTvShow(id: widget.id));
      BlocProvider.of<TvShowWatchlistBloc>(context)
        .add(TvShowGetStatusWatchlist(tvShowId: widget.id));
      BlocProvider.of<TvShowRecommendationBloc>(context)
        .add(OnGetRecommendationTvShow(tvShowId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvShowDetailState tvShowDetailState =
        context.watch<TvShowDetailBloc>().state;
    TvShowRecommendationState tvShowRecommendationState =
        context.watch<TvShowRecommendationBloc>().state;

    return Scaffold(
        body: tvShowDetailState is TvShowDetailLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : tvShowDetailState is TvShowDetailHasData
                ? SafeArea(
                    child: TvShowDetailContent(
                      tvShowDetailState.result,
                      tvShowRecommendationState is TvShowRecommendationHasData
                          ? tvShowRecommendationState.result
                          : List.empty(),
                    ),
                  )
                : const Text('Failed'));
  }
}

class TvShowDetailContent extends StatefulWidget {
  final TvShowDetail tvShowDetail;
  final List<TvShow> listRecommendations;

  const TvShowDetailContent(this.tvShowDetail, this.listRecommendations, {Key? key}) : super(key: key);

  @override
  _TvShowDetailContentState createState() => _TvShowDetailContentState();
}

class _TvShowDetailContentState extends State<TvShowDetailContent>
    with TickerProviderStateMixin {
  int _startingTabCount = 0;
  final List<Widget> _generalWidgets = List<Widget>.empty().toList();
  List<Tab> _tabs = List<Tab>.empty().toList();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _startingTabCount = widget.tvShowDetail.numberOfSeasons;
    _tabs = getTabs(_startingTabCount);
    _tabController = getTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentOrientation = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvShowDetail.posterPath}',
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvShowDetail.name,
                              style: kHeading5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _showGenres(
                                              widget.tvShowDetail.genres),
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
                                            rating: widget
                                                    .tvShowDetail.voteAverage /
                                                2,
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
                                            '${widget.tvShowDetail.voteAverage}',
                                            style: const TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                WatchlistButton(
                                    tvShowDetail: widget.tvShowDetail)
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvShowDetail.overview.isNotEmpty
                                  ? widget.tvShowDetail.overview
                                  : "-",
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: widget.listRecommendations.isNotEmpty? 150 : 0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvShow =
                                      widget.listRecommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvShowDetailPage.ROUTE_NAME,
                                          arguments: tvShow.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.listRecommendations.length,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: currentOrientation == Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.35
                                  : MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TabBar(
                                      tabs: _tabs,
                                      controller: _tabController,
                                      isScrollable: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: getWidgets(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
        ),
      ],
    );
  }

  String _showGenres(List<TvShowGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 1; i <= count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
      text: "$widgetNumber",
    );
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 1; i <= _tabs.length; i++) {
      _generalWidgets.add(
          _TvShowsDetailSeasons(id: widget.tvShowDetail.id, numberSeason: i));
    }
    return _generalWidgets;
  }
}

class _TvShowsDetailSeasons extends StatefulWidget {
  final int id;
  final int numberSeason;

  const _TvShowsDetailSeasons({required this.id, required this.numberSeason});

  @override
  __TvShowsDetailSeasonsState createState() => __TvShowsDetailSeasonsState();
}

class __TvShowsDetailSeasonsState extends State<_TvShowsDetailSeasons> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvShowSeasonBloc>(context)
        .add(OnGetSeasonTvShow(
            tvShowId: widget.id, seasonNumber: widget.numberSeason));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvShowSeasonState tvShowSeasonState =
        context.watch<TvShowSeasonBloc>().state;

    return tvShowSeasonState is TvShowSeasonLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : tvShowSeasonState is TvShowSeasonHasData
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tvShowSeasonState.result.episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeCard(tvShowSeasonState.result.episodes[index]);
                })
            : const Text('Failed');
  }
}

class WatchlistButton extends StatelessWidget {
  final TvShowDetail tvShowDetail;

  const WatchlistButton({Key? key, required this.tvShowDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TvShowWatchlistBloc, TvShowWatchlistState>(
        builder: (BuildContext context, state) {
      bool isAddedToWatchlist =
          context.select<TvShowWatchlistBloc, bool>((tvShowWatchlistBloc) {
        return (tvShowWatchlistBloc.state is TvShowLoadWatchlistStatus)
            ? (tvShowWatchlistBloc.state as TvShowLoadWatchlistStatus)
                .isWatchList
            : false;
      });

      return ElevatedButton(
        onPressed: () async {
          if (isAddedToWatchlist) {
            BlocProvider.of<TvShowWatchlistBloc>(context, listen: false)
              .add(TvShowRemoveFromWatchlist(tvShowDetail));
          } else {
            BlocProvider.of<TvShowWatchlistBloc>(context, listen: false)
              .add(TvShowAddWatchlist(tvShowDetail));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isAddedToWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
            const Text('Watchlist'),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is TvShowAddWatchlistSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2)));
      } else if (state is TvShowAddWatchlistError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text(
                state.error,
              ));
            });
      } else if (state is TvShowRemoveWatchlistSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2)));
      } else if (state is TvShowRemoveWatchlistError) {
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
