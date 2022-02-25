import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class SaveWatchlistTvShow {
  final TvShowRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.saveWatchlist(tvShow);
  }
}
