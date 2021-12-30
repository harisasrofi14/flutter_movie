import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/entities/tv_show_season.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows();

  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowsRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);

  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow);

  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();

  Future<Either<Failure, TvShowSeason>> getTvShowSeason(
      int id, int seasonNumber);
}
