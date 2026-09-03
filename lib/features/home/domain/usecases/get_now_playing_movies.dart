import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/home/domain/repositories/home_repository.dart';

class GetNowPlayingMovies {
  final HomeRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<List<Movie>> call(int page) async {
    return await repository.getNowPlayingMovies(page);
  }
}