import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

abstract class ComingSoonState {}

class ComingSoonInitial extends ComingSoonState {}

class ComingSoonLoading extends ComingSoonState {}

class ComingSoonLoaded extends ComingSoonState {
  final List<Movie> movies;
  final bool isLoadingMore;

  ComingSoonLoaded(
    this.movies, {
    this.isLoadingMore = false,
  });
}

class ComingSoonEmpty extends ComingSoonState {}

class ComingSoonError extends ComingSoonState {
  final String message;

  ComingSoonError(this.message);
}