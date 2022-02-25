import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_show.dart';
import 'package:tv/domain/usecases/get_tv_show_recommendations.dart';

part 'tv_show_recommendation_event.dart';

part 'tv_show_recommendation_state.dart';

class TvShowRecommendationBloc
    extends Bloc<TvShowRecommendationEvent, TvShowRecommendationState> {
  final GetTvShowRecommendations getTvShowRecommendations;

  TvShowRecommendationBloc({required this.getTvShowRecommendations})
      : super(TvShowRecommendationEmpty()) {
    on<OnGetRecommendationTvShow>((event, emit) async {
      final int tvShowId = event.tvShowId;
      emit(TvShowRecommendationLoading());
      final result = await getTvShowRecommendations.execute(tvShowId);
      result.fold((failure) {
        emit(TvShowRecommendationError());
      }, (result) => emit(TvShowRecommendationHasData(result)));
    });
  }
}
