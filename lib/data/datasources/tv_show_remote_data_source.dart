

import 'dart:convert';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_shows_response.dart';
import 'package:http/http.dart' as http;

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getNowPlayingTvShows();
  Future<List<TvShowModel>> getPopularTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  //Future<MovieDetailResponse> getMovieDetail(int id);
  //Future<List<TvShowModel>> getTvShowRecommendations(int id);
  //Future<List<TvShowModel>> searchMovies(String query);
}
class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {

  static const API_KEY = 'api_key=40ebbdf7ace0aedc176087ca768e21e2';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  
  @override
  Future<List<TvShowModel>> getNowPlayingTvShows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY&language=en-US'));

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if(response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if(response.statusCode == 200){
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchMovies(String query) {

    throw UnimplementedError();
  }


}