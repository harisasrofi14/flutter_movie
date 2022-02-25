import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show_season.dart';
import 'package:tv/domain/usecases/get_tv_show_season.dart';

part 'tv_show_season_event.dart';
part 'tv_show_season_state.dart';

class TvShowSeasonBloc extends Bloc<TvShowSeasonEvent, TvShowSeasonState> {
  final GetTvShowSeason getTvShowSeason;

  TvShowSeasonBloc({required this.getTvShowSeason})
      : super(TvShowSeasonEmpty()) {
    on<OnGetSeasonTvShow>((event, emit) async {
      final int tvShowId = event.tvShowId;
      final int seasonNumber = event.seasonNumber;
      emit(TvShowSeasonLoading());
      final result = await getTvShowSeason.execute(tvShowId, seasonNumber);
      result.fold((failure) {
        emit(TvShowSeasonError());
      }, (result) => emit(TvShowSeasonHasData(result)));
    });
  }
}
