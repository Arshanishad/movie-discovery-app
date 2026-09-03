import 'package:movie_discovery_app/core/api/api_client.dart';
import 'package:movie_discovery_app/core/constants/api_constants.dart';
import 'package:movie_discovery_app/features/home/data/models/movie_model.dart';

class HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSource(this.apiClient);

  Future<List<MovieModel>> getPopularMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.popularMovies,
      queryParameters: {
        'page': page,
      },
    );

    final data = response.data as Map<String, dynamic>;

    final results = data['results'] as List;

    return results
        .map(
          (json) => MovieModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<MovieModel>> getTrendingMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.trendingMovies,
      queryParameters: {
        'page': page,
      },
    );

    final data = response.data as Map<String, dynamic>;

    final results = data['results'] as List;

    return results
        .map(
          (json) => MovieModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.nowPlayingMovies,
      queryParameters: {
        'page': page,
      },
    );

    final data = response.data as Map<String, dynamic>;

    final results = data['results'] as List;

    return results
        .map(
          (json) => MovieModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.topRatedMovies,
      queryParameters: {
        'page': page,
      },
    );

    final data = response.data as Map<String, dynamic>;

    final results = data['results'] as List;

    return results
        .map(
          (json) => MovieModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}