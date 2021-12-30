import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_show.dart';
import 'package:flutter/material.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  var _watchlistTvShows = <TvShow>[];

  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistTvShowNotifier({required this.getWatchlistTvShows});

  final GetWatchlistTvShows getWatchlistTvShows;

  Future<void> fetchWatchlistTvShow() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShows = moviesData;
        notifyListeners();
      },
    );
  }
}
