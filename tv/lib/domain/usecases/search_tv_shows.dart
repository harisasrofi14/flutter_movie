import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class SearchTvShows {
  final TvShowRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
