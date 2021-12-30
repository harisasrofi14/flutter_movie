import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_season.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowSeason {
  final TvShowRepository repository;

  GetTvShowSeason(this.repository);

  Future<Either<Failure, TvShowSeason>> execute(int id, int seasonNumber) {
    return repository.getTvShowSeason(id, seasonNumber);
  }
}
