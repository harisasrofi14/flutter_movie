import 'dart:io';

import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie_watch_list/movie_watch_list_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tv/domain/entities/tv_show_episode.dart';
import 'package:tv/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_now_playing/tv_show_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_popular/tv_show_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_recommendation/tv_show_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_season/tv_show_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_top_rated/tv_show_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_watch_list/tv_show_watch_list_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_show_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv/presentation/pages/tv_show_detail_page.dart';
import 'package:tv/presentation/pages/tv_show_episode_detail_page.dart';
import 'package:tv/presentation/pages/tv_show_page.dart';
import 'package:tv/utils/utils.dart';

//void main() async
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD2VAjivWJiIU_orR5xSUrY_1buJfyZ8xw",
            appId: "1:61519422003:ios:ec3f4a507f45e0f6cb7946",
            messagingSenderId: "61519422003",
            projectId: "ditonton-5be83"));
  } else {
    await Firebase.initializeApp();
  }
  await SSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<MoviePopularBloc>()),
        BlocProvider(create: (_) => di.locator<MovieTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<MovieNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowPopularBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowWatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<TvShowSeasonBloc>()),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final type = settings.arguments as String;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        type: type,
                      ));
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvShowPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvShowPage());
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case PopularTvShowPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvShowPage());
            case TopRatedTvShowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvShowsPage());
            case TvShowEpisodeDetailPage.ROUTE_NAME:
              final episode = settings.arguments as TvShowEpisodes;
              return MaterialPageRoute(
                  builder: (_) => TvShowEpisodeDetailPage(episodes: episode));
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
