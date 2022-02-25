import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc({required this.getNowPlayingMovies})
      : super(MovieNowPlayingEmpty()) {
    on<OnGetNowPlayingMovies>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieNowPlayingError());
      }, (result) => emit(MovieNowPlayingHasData(result)));
    });
  }
}
