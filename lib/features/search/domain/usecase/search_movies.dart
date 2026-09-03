import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/search/domain/repositories/search_repository.dart';

class SearchMovies {
  final SearchRepository repository;

  SearchMovies(this.repository);

  Future<List<Movie>> call(String query) async {
    return await repository.searchMovies(query);
  }
}