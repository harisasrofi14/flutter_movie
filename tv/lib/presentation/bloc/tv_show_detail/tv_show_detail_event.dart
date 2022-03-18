part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent {
  const TvShowDetailEvent();
}

class OnGetDetailTvShow extends TvShowDetailEvent {
  final int id;

  const OnGetDetailTvShow({required this.id});
}
