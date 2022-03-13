import 'package:tv/data/models/tv_show_table.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';
import 'package:tv/domain/entities/tv_show_season.dart';

final testTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    firstAirDate: '12-12-2021',
    genres: [const TvShowGenre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    overview: 'overview',
    popularity: 5.0,
    posterPath: 'posterPath',
    status: 'status',
    voteAverage: 1,
    voteCount: 1,
    numberOfSeasons: 1);

const testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
final testEpisode = TvShowEpisodes(
    airDate: 'airDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 3.0,
    voteCount: 5);

final testTvSeason = TvShowSeason(
    sId: 'sID',
    airDate: 'airDate',
    episodes: [testEpisode],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1);

final testTvShow = TvShow(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
  firstAirDate: 'firstAirDate',
  name: 'name',
);

final testTvShowList = [testTvShow];
