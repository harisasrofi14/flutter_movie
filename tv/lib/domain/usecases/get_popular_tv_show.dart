import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class GetPopularTvShows {
  final TvShowRepository repository;

  GetPopularTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShows();
  }
}
