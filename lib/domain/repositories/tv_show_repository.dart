

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  //Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowsRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  //Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  //Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}