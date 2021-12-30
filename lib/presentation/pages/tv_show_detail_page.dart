import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_season_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv_show';

  final int id;

  TvShowDetailPage({required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .fetchTvShowDetail(widget.id);
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowState == RequestState.Loaded) {
            final tvShow = provider.tvShow;
            return SafeArea(
              child: TvShowDetailContent(
                tvShow,
                provider.tvShowRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class TvShowDetailContent extends StatefulWidget {
  final TvShowDetail tvShowDetail;
  final List<TvShow> listRecommendations;
  final bool isAddedWatchList;

  TvShowDetailContent(
      this.tvShowDetail, this.listRecommendations, this.isAddedWatchList);

  @override
  _TvShowDetailContentState createState() => _TvShowDetailContentState();
}

class _TvShowDetailContentState extends State<TvShowDetailContent>
    with TickerProviderStateMixin {
  int _startingTabCount = 0;
  List<Widget> _generalWidgets = List<Widget>.empty().toList();
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
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                            SizedBox(
                              height: 5,
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
                                          _showGenres(
                                              widget.tvShowDetail.genres),
                                        ),
                                      ),
                                      SizedBox(
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
                                                Icon(
                                              Icons.star,
                                              color: kMikadoYellow,
                                            ),
                                            itemSize: 24,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${widget.tvShowDetail.voteAverage}',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!widget.isAddedWatchList) {
                                      await Provider.of<TvShowDetailNotifier>(
                                              context,
                                              listen: false)
                                          .addWatchlist(widget.tvShowDetail);
                                    } else {
                                      await Provider.of<TvShowDetailNotifier>(
                                              context,
                                              listen: false)
                                          .removeFromWatchlist(
                                              widget.tvShowDetail);
                                    }

                                    final message =
                                        Provider.of<TvShowDetailNotifier>(
                                                context,
                                                listen: false)
                                            .watchlistMessage;

                                    if (message ==
                                            TvShowDetailNotifier
                                                .watchlistAddSuccessMessage ||
                                        message ==
                                            TvShowDetailNotifier
                                                .watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      widget.isAddedWatchList
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvShowDetail.overview.isNotEmpty
                                  ? widget.tvShowDetail.overview
                                  : "-",
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvShowDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                        RequestState.Loaded &&
                                    widget.listRecommendations.length > 0) {
                                  return Container(
                                      height: 150,
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
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            widget.listRecommendations.length,
                                      ));
                                } else {
                                  return Text("-");
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
                              height: currentOrientation == Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.35
                                  : MediaQuery.of(context).size.height * 0.7,
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
                                      padding: EdgeInsets.only(top: 10),
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: getWidgets(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
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
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
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

  _TvShowsDetailSeasons({required this.id, required this.numberSeason});

  @override
  __TvShowsDetailSeasonsState createState() => __TvShowsDetailSeasonsState();
}

class __TvShowsDetailSeasonsState extends State<_TvShowsDetailSeasons> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowSeasonNotifier>(context, listen: false)
          .fetchTvShowSeason(widget.id, widget.numberSeason);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvShowSeasonNotifier>(builder: (context, data, child) {
      if (data.state == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (data.state == RequestState.Error) {
        return Text(data.message);
      } else if (data.state == RequestState.Loaded) {
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.tvShowSeason!.episodes.length,
            itemBuilder: (context, index) {
              return EpisodeCard(data.tvShowSeason!.episodes[index]);
            });
      } else {
        return Text("-");
      }
    });
  }
}
