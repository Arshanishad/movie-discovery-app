import 'package:movie_discovery_app/core/api/api_client.dart';
import 'package:movie_discovery_app/core/constants/api_constants.dart';
import 'package:movie_discovery_app/features/home/data/models/movie_model.dart';

class ComingSoonRemoteDataSource {
  final ApiClient apiClient;  
  ComingSoonRemoteDataSource(this.apiClient);

  Future<List<MovieModel>> getUpcomingMovies(int page) async {
  final response = await apiClient.get(
    ApiConstants.upcomingMovies,
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