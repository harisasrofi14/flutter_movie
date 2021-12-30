import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:ditonton/presentation/pages/tv_show_episode_detail_page.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final TvShowEpisode episode;

  EpisodeCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          TvShowEpisodeDetailPage.ROUTE_NAME,
          arguments: episode,
        );
      },
      child: Container(
        width: 180,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                  placeholder: (context, url) => Container(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset('assets/image/no-thumbnail.png',
                        height: 100, width: 180, fit: BoxFit.cover),
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                child: Text(
                  episode.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                child: Text(
                  episode.overview.isNotEmpty
                      ? episode.overview
                      : episode.airDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
