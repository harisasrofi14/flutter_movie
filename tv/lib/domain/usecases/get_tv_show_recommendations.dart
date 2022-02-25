import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class GetTvShowRecommendations {
  final TvShowRepository repository;

  GetTvShowRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvShowsRecommendations(id);
  }
}
