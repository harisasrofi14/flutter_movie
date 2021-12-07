import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_show.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowPlayingTvShow = <TvShow>[];

  List<TvShow> get nowPlayingTvShow => _nowPlayingTvShow;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvShow = <TvShow>[];

  List<TvShow> get popularTvShow => _popularTvShow;

  RequestState _popularTvShowState = RequestState.Empty;

  RequestState get popularTvShowState => _popularTvShowState;

  var _topRatedTvShow = <TvShow>[];

  List<TvShow> get topRatedTvShow => _topRatedTvShow;

  RequestState _topRatedTvShowState = RequestState.Empty;

  RequestState get topRatedTvShowState => _topRatedTvShowState;

  String _message = '';

  String get message => _message;

  TvShowListNotifier(
      {required this.getNowPlayingTvShows,
      required this.getPopularTvShows,
      required this.getTopRatedTvShows});

  final GetNowPlayingTvShows getNowPlayingTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchNowPlayingTvShows() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvShows.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvShow = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

    result.fold(
      (failure) {
        _popularTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowState = RequestState.Loaded;
        _popularTvShow = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        _topRatedTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowState = RequestState.Loaded;
        _topRatedTvShow = tvShowsData;
        notifyListeners();
      },
    );
  }
}
