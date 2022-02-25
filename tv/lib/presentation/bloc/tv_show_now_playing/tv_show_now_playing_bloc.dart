import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_show.dart';

part 'tv_show_now_playing_event.dart';
part 'tv_show_now_playing_state.dart';

class TvShowNowPlayingBloc
    extends Bloc<TvShowNowPlayingEvent, TvShowNowPlayingState> {
  final GetNowPlayingTvShows getNowPlayingTvShows;

  TvShowNowPlayingBloc({required this.getNowPlayingTvShows})
      : super(TvShowNowPlayingEmpty()) {
    on<OnGetNowPlayingTvShow>((event, emit) async {
      emit(TvShowNowPlayingLoading());
      final result = await getNowPlayingTvShows.execute();
      result.fold((failure) {
        emit(TvShowNowPlayingError());
      }, (result) => emit(TvShowNowPlayingHasData(result)));
    });
  }
}
