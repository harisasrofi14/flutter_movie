import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc({required this.getPopularMovies})
      : super(MoviePopularEmpty()) {
    on<OnGetPopularMovies>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await getPopularMovies.execute();
      result.fold((failure) {
        emit(MoviePopularError());
      }, (r) => emit(MoviePopularHasData(r)));
    });
  }
}
