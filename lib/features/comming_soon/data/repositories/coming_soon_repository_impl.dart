import 'package:movie_discovery_app/features/comming_soon/data/datasource/comming_soon_remote_data_source.dart';
import 'package:movie_discovery_app/features/comming_soon/domain/repositories/comming_soon_repository.dart';
import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';


class ComingSoonRepositoryImpl implements ComingSoonRepository {
  final ComingSoonRemoteDataSource remoteDataSource;

  ComingSoonRepositoryImpl(this.remoteDataSource);
@override
Future<List<Movie>> getUpcomingMovies(int page) async {
  return await remoteDataSource.getUpcomingMovies(page);
}
}