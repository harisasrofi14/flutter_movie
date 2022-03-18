part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchEvent extends Equatable {
  const TvShowSearchEvent();
}

class TvShowOnQueryChanged extends TvShowSearchEvent {
  final String query;

  const TvShowOnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
