import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_watch_list_event.dart';
part 'movie_watch_list_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc(
      {required this.removeWatchlist,
      required this.getWatchlistStatus,
      required this.saveWatchlist,
      required this.getWatchlistMovies})
      : super(MovieRemoveWatchlistEmpty()) {
    on<RemoveFromWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await removeWatchlist.execute(movie);
      result.fold((failure) {
        emit(MovieRemoveWatchlistError(error: failure.message));
      }, (r) {
        emit(MovieRemoveWatchlistSuccess(message: r));
        add(GetStatusWatchlist(movieId: movie.id));
      });
    });
    on<AddWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await saveWatchlist.execute(movie);
      result.fold((failure) {
        emit(MovieAddWatchlistError(error: failure.message));
      }, (r) async {
        emit(MovieAddWatchlistSuccess(message: r));
        add(GetStatusWatchlist(movieId: movie.id));
      });
    });

    on<GetStatusWatchlist>((event, emit) async {
      final movieId = event.movieId;
      final result = await getWatchlistStatus.execute(movieId);
      emit(MovieLoadWatchlistStatus(isWatchList: result));
    });

    on<GetAllMovieWatchlist>((event, emit) async {
      emit(const MovieGetAllWatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold((l) {
        MovieGetAllWatchlistError(error: l.message);
      }, (r) => emit(MovieGetAllWatchlistSuccess(movies: r)));
    });
  }
}
