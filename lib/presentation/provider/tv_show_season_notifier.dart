import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_season.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season.dart';
import 'package:flutter/material.dart';

class TvShowSeasonNotifier extends ChangeNotifier {
  final GetTvShowSeason getTvShowSeason;

  TvShowSeasonNotifier(this.getTvShowSeason);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  TvShowSeason? _tvShowSeason;

  TvShowSeason? get tvShowSeason => _tvShowSeason;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvShowSeason(int id, int seasonNUmber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvShowSeason.execute(id, seasonNUmber);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (season) {
        _tvShowSeason = season;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
