part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  List<Object?> get props => [];
}

class OnGetDetailTvShow extends TvShowDetailEvent {
  final int id;

  OnGetDetailTvShow({required this.id});

  @override
  List<Object?> get props => [];
}
