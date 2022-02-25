import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class GetTopRatedTvShows {
  final TvShowRepository repository;

  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShows();
  }
}
