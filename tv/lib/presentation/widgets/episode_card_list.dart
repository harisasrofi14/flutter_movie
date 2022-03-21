import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';
import 'package:tv/presentation/pages/tv_show_episode_detail_page.dart';

import '../../tv.dart';

class EpisodeCard extends StatelessWidget {
  final TvShowEpisodes episode;

   const EpisodeCard(this.episode, {Key? key}) : super(key: key);
  void _navigateToTvShowEpisodeDetailPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      TvShowEpisodeDetailPage.ROUTE_NAME,
      arguments: episode,
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToTvShowEpisodeDetailPage(context);
        // Navigator.pushNamed(
        //   context,
        //   TvShowEpisodeDetailPage.ROUTE_NAME,
        //   arguments: episode,
        // );
      },
      child: SizedBox(
        width: 200,
        child: Card(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                  placeholder: (context, url) => const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset('assets/image/no-thumbnail.png',
                        height: 100,  fit: BoxFit.fill),
                  ),
                ),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children :[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                child: Text(
                  episode.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                child: Text(
                  episode.overview.isNotEmpty
                      ? episode.overview
                      : episode.airDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
