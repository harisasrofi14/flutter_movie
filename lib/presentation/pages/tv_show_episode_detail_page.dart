import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvShowEpisodeDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/episode-detail';

  final TvShowEpisode episode;

  TvShowEpisodeDetailPage({required this.episode});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
            width: screenWidth,
            placeholder: (context, url) => Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
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
                                episode.name,
                                style: kHeading5,
                              ),
                              SizedBox(height: 10),
                              Text(
                                episode.airDate,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: episode.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${episode.voteAverage}',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                episode.overview,
                              ),
                              SizedBox(height: 10),
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
              initialChildSize: 0.8,
              minChildSize: 0.75,
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
          )
        ]),
      ),
    );
  }
}
