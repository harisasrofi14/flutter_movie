import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_show.dart';

part 'tv_show_watch_list_event.dart';
part 'tv_show_watch_list_state.dart';

class TvShowWatchlistBloc
    extends Bloc<TvShowWatchlistEvent, TvShowWatchlistState> {
  final RemoveWatchlistTvShow removeWatchlistTvShow;
  final GetTvShowWatchListStatus getTvShowWatchListStatus;
  final SaveWatchlistTvShow saveWatchlistTvShow;
  final GetWatchlistTvShows getWatchlistTvShows;

  TvShowWatchlistBloc(
      {required this.removeWatchlistTvShow,
      required this.getTvShowWatchListStatus,
      required this.saveWatchlistTvShow,
      required this.getWatchlistTvShows})
      : super(TvShowRemoveWatchlistEmpty()) {
    on<TvShowRemoveFromWatchlist>((event, emit) async {
      final tvShow = event.tvShowDetail;
      final result = await removeWatchlistTvShow.execute(tvShow);
      result.fold((failure) {
        emit(TvShowRemoveWatchlistError(error: failure.message));
      }, (r) {
        emit(TvShowRemoveWatchlistSuccess(message: r));
        add(TvShowGetStatusWatchlist(tvShowId: tvShow.id));
      });
    });
    on<TvShowAddWatchlist>((event, emit) async {
      final tvShow = event.tvShowDetail;
      final result = await saveWatchlistTvShow.execute(tvShow);
      result.fold((failure) {
        emit(TvShowAddWatchlistError(error: failure.message));
      }, (r) async {
        emit(TvShowAddWatchlistSuccess(message: r));
        add(TvShowGetStatusWatchlist(tvShowId: tvShow.id));
      });
    });

    on<TvShowGetStatusWatchlist>((event, emit) async {
      final tvShowId = event.tvShowId;
      final result = await getTvShowWatchListStatus.execute(tvShowId);
      emit(TvShowLoadWatchlistStatus(isWatchList: result));
    });

    on<GetAllTvShowWatchlist>((event, emit) async {
      emit(TvShowGetAllWatchlistLoading());
      final result = await getWatchlistTvShows.execute();
      result.fold((l) {
        TvShowGetAllWatchlistError(error: l.message);
      }, (r) => emit(TvShowGetAllWatchlistSuccess(tvShows: r)));
    });
  }
}
