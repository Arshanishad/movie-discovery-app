import 'package:movie_discovery_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies(int page) async {
    return await remoteDataSource.getPopularMovies(page);
  }

  @override
  Future<List<Movie>> getTrendingMovies(int page) async {
    return await remoteDataSource.getTrendingMovies(page);
  }

  @override
  Future<List<Movie>> getNowPlayingMovies(int page) async {
    return await remoteDataSource.getNowPlayingMovies(page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies(int page) async {
    return await remoteDataSource.getTopRatedMovies(page);
  }
}