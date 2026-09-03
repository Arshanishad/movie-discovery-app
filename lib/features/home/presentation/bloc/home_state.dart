import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> popularMovies;
  final List<Movie> trendingMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;

  final bool isPopularLoadingMore;
  final bool isTrendingLoadingMore;
  final bool isNowPlayingLoadingMore;
  final bool isTopRatedLoadingMore;

  HomeLoaded({
    required this.popularMovies,
    required this.trendingMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    this.isPopularLoadingMore = false,
    this.isTrendingLoadingMore = false,
    this.isNowPlayingLoadingMore = false,
    this.isTopRatedLoadingMore = false,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}