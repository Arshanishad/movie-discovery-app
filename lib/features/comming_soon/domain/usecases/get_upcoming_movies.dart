import 'package:movie_discovery_app/features/comming_soon/domain/repositories/comming_soon_repository.dart';
import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

class GetUpcomingMovies {
  final ComingSoonRepository repository;
  GetUpcomingMovies(this.repository);

  Future<List<Movie>> call(int page) async {
    return await repository.getUpcomingMovies(page);
  }
}