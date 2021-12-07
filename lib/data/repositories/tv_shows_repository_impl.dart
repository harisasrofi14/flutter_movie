

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {

  final TvShowRemoteDataSource remoteDataSource;
//  final MovieLocalDataSource localDataSource;

  TvShowRepositoryImpl({
    required this.remoteDataSource,
  //  required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() async {
    try {
      final result = await remoteDataSource.getPopularTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows() async {
    try {
      final result = await remoteDataSource.getTopRatedTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowsRecommendations(int id) {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows() {

    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) {
 
    throw UnimplementedError();
  }
}
