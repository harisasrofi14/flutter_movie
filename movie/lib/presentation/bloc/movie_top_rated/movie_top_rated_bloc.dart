import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';

part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedBloc({required this.getTopRatedMovies})
      : super(MovieTopRatedEmpty()) {
    on<OnGetTopRatedMovies>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MovieTopRatedError());
      }, (result) => emit(MovieTopRatedHasData(result)));
    });
  }
}
