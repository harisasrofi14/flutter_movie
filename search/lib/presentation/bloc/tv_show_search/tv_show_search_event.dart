part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchEvent {
  const TvShowSearchEvent();
}

class TvShowOnQueryChanged extends TvShowSearchEvent {
  final String query;

  const TvShowOnQueryChanged(this.query);
}
