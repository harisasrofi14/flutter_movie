import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_show.dart';

part 'tv_show_top_rated_event.dart';
part 'tv_show_top_rated_state.dart';

class TvShowTopRatedBloc
    extends Bloc<TvShowTopRatedEvent, TvShowTopRatedState> {
  final GetTopRatedTvShows getTopRatedTvShows;

  TvShowTopRatedBloc({required this.getTopRatedTvShows})
      : super(TvShowTopRatedEmpty()) {
    on<OnGetTopRatedTvShow>((event, emit) async {
      emit(TvShowTopRatedLoading());
      final result = await getTopRatedTvShows.execute();
      result.fold((failure) {
        emit(TvShowTopRatedError());
      }, (result) => emit(TvShowTopRatedHasData(result)));
    });
  }
}
