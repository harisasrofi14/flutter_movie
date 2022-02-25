



import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/search_tv_shows.dart';

part 'tv_show_search_state.dart';
part 'tv_show_search_event.dart';

class TvShowSearchBloc extends Bloc<TvShowSearchEvent, TvShowSearchState> {
  final SearchTvShows searchTvShows;

  TvShowSearchBloc( {required this.searchTvShows})
      : super(TvShowSearchEmpty()) {
    on<TvShowOnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvShowSearchLoading());

      final result = await searchTvShows.execute(query);

      result.fold((failure) {
        emit(TvShowSearchError(failure.message));
      }, (data) {
        emit(TvShowSearchHasData(data));
      });
    });
  }
}