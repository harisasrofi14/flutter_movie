import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show_season.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class GetTvShowSeason {
  final TvShowRepository repository;

  GetTvShowSeason(this.repository);

  Future<Either<Failure, TvShowSeason>> execute(int id, int seasonNumber) {
    return repository.getTvShowSeason(id, seasonNumber);
  }
}
