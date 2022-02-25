import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie_watch_list/movie_watch_list_bloc.dart';
import 'package:tv/data/datasources/db/tv_show_database_helper.dart';
import 'package:tv/data/datasources/tv_show_local_data_source.dart';
import 'package:tv/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv/data/repositories/tv_shows_repository_impl.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_show.dart';
import 'package:tv/domain/usecases/get_popular_tv_show.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_show.dart';
import 'package:tv/domain/usecases/get_tv_show_detail.dart';
import 'package:tv/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv/domain/usecases/get_tv_show_season.dart';
import 'package:tv/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_show.dart';
import 'package:tv/domain/usecases/search_tv_shows.dart';
import 'package:tv/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_now_playing/tv_show_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_popular/tv_show_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_recommendation/tv_show_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_season/tv_show_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_top_rated/tv_show_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_watch_list/tv_show_watch_list_bloc.dart';


final locator = GetIt.instance;

void init() {

  locator.registerFactory(() => MovieSearchBloc(searchMovies: locator()));

  locator.registerFactory(() => MoviePopularBloc(getPopularMovies: locator()));

  locator
      .registerFactory(() => MovieTopRatedBloc(getTopRatedMovies: locator()));

  locator.registerFactory(() => MovieWatchlistBloc(
      removeWatchlist: locator(),
      getWatchlistStatus: locator(),
      saveWatchlist: locator(),
      getWatchlistMovies: locator()));
  locator.registerFactory(
      () => MovieRecommendationBloc(getMovieRecommendations: locator()));
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(() => TvShowSearchBloc(searchTvShows: locator()));
  locator
      .registerFactory(() => TvShowPopularBloc(getPopularTvShows: locator()));
  locator
      .registerFactory(() => TvShowTopRatedBloc(getTopRatedTvShows: locator()));
  locator.registerFactory(
      () => TvShowNowPlayingBloc(getNowPlayingTvShows: locator()));
  locator.registerFactory(() => TvShowDetailBloc(getTvShowDetail: locator()));
  locator.registerFactory(() => TvShowWatchlistBloc(
      removeWatchlistTvShow: locator(),
      getTvShowWatchListStatus: locator(),
      saveWatchlistTvShow: locator(),
      getWatchlistTvShows: locator()));
  locator.registerFactory(
      () => TvShowRecommendationBloc(getTvShowRecommendations: locator()));
  locator.registerFactory(() => TvShowSeasonBloc(getTvShowSeason: locator()));

  locator.registerFactory(
      () => MovieNowPlayingBloc(getNowPlayingMovies: locator()));
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvShowWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowSeason(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(() => TvShowRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));
  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvShowDatabaseHelper>(
      () => TvShowDatabaseHelper());

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SSLPinning.client);
}
