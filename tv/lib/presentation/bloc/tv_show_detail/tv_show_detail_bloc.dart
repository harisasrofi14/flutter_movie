import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show_detail.dart';
import 'package:tv/domain/usecases/get_tv_show_detail.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;

  TvShowDetailBloc({required this.getTvShowDetail})
      : super(TvShowDetailEmpty()) {
    on<OnGetDetailTvShow>((event, emit) async {
      final id = event.id;
      emit(TvShowDetailLoading());
      final result = await getTvShowDetail.execute(id);
      result.fold((failure) {
        emit(TvShowDetailError());
      }, (result) => emit(TvShowDetailHasData(result)));
    });
  }
}
