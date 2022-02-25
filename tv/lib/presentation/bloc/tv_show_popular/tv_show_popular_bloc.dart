import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/get_popular_tv_show.dart';

part 'tv_show_popular_event.dart';
part 'tv_show_popular_state.dart';

class TvShowPopularBloc extends Bloc<TvShowPopularEvent, TvShowPopularState> {
  final GetPopularTvShows getPopularTvShows;

  TvShowPopularBloc({required this.getPopularTvShows})
      : super(TvShowPopularEmpty()) {
    on<OnGetPopularTvShow>((event, emit) async {
      emit(TvShowPopularLoading());
      final result = await getPopularTvShows.execute();
      result.fold((failure) {
        emit(TvShowPopularError());
      }, (r) => emit(TvShowPopularHasData(r)));
    });
  }
}
