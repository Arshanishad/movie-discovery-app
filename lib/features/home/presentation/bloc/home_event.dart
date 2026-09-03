import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class HomeEvent {}

class GetHomeMoviesEvent extends HomeEvent {}

class LoadMorePopularMoviesEvent extends HomeEvent {}

class LoadMoreTrendingMoviesEvent extends HomeEvent {}

class LoadMoreNowPlayingMoviesEvent extends HomeEvent {}

class LoadMoreTopRatedMoviesEvent extends HomeEvent {}