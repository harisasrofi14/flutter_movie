import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

import '../../tv.dart';

class GetTvShowDetail {
  final TvShowRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
