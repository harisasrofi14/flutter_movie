
part of 'movie_now_playing_bloc.dart';


abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();

  @override
  List<Object?> get props => [];
}

class OnGetNowPlayingMovies extends MovieNowPlayingEvent {
  @override
  List<Object?> get props => [];
}