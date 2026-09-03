import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/api/api_client.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:movie_discovery_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_top_rated.dart';
import 'package:movie_discovery_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_event.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_state.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/home_banner.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/home_previews.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/home_top_actions.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/now_playing_section.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/popular_movies_section.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/top_rated_section.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/trending_movies_section.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) {
        final apiClient = ApiClient();
        final remoteDataSource = HomeRemoteDataSource(apiClient);
        final repository = HomeRepositoryImpl(remoteDataSource);
        final getPopularMovies = GetPopularMovies(repository);
        final getTrendingMovies = GetTrendingMovies(repository);
        final getNowPlayingMovies = GetNowPlayingMovies(repository);
        final getTopRatedMovies = GetTopRatedMovies(repository);

        return HomeBloc(
          getPopularMovies,
          getTrendingMovies,
          getNowPlayingMovies,
          getTopRatedMovies,
        )..add(GetHomeMoviesEvent());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: w * 0.04,
                      top: w * 0.05,
                      bottom: w * 0.03,
                    ),
                    child: Text(
                      'Welcome, ${widget.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const HomeBanner(),
                  const HomeTopActions(),
                  const HomePreviews(),
                  const PopularMoviesSection(),
                  const TrendingMoviesSection(),
                  const NowPlayingSection(),
                  const TopRatedSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
