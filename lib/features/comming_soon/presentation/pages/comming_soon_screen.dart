import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/api/api_client.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';
import 'package:movie_discovery_app/features/comming_soon/data/datasource/comming_soon_remote_data_source.dart';
import 'package:movie_discovery_app/features/comming_soon/data/repositories/coming_soon_repository_impl.dart';
import 'package:movie_discovery_app/features/comming_soon/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/bloc/comming_soon_bloc.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/bloc/comming_soon_event.dart';
import 'package:movie_discovery_app/features/comming_soon/presentation/bloc/comming_soon_state.dart';
import 'package:shimmer/shimmer.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final apiClient = ApiClient();
        final remoteDataSource = ComingSoonRemoteDataSource(apiClient);
        final repository = ComingSoonRepositoryImpl(remoteDataSource);
        final getUpcomingMovies = GetUpcomingMovies(repository);
        return ComingSoonBloc(getUpcomingMovies)
          ..add(GetUpcomingMoviesEvent(1));
      },
      child: const _ComingSoonView(),
    );
  }
}

class _ComingSoonView extends StatefulWidget {
  const _ComingSoonView();

  @override
  State<_ComingSoonView> createState() => _ComingSoonViewState();
}

class _ComingSoonViewState extends State<_ComingSoonView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final bloc = context.read<ComingSoonBloc>();

      if (!bloc.isLoadingMore && !bloc.hasReachedEnd) {
        bloc.add(GetUpcomingMoviesEvent(bloc.currentPage + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: w * 0.06,
            left: w * 0.05,
            right: w * 0.05,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: w * 0.09,
                    height: w * 0.09,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: w * 0.055,
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.05),
              Expanded(
                child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
                  builder: (context, state) {
                    if (state is ComingSoonLoading) {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return _shimmerCard();
                        },
                      );
                    }
                    if (state is ComingSoonError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white70,
                              size: w * 0.12,
                            ),

                            SizedBox(height: w * 0.04),

                            Text(
                              'Something went wrong',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: w * 0.02),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: w * 0.08,
                              ),
                              child: Text(
                                state.message,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: w * 0.032,
                                ),
                              ),
                            ),

                            SizedBox(height: w * 0.05),

                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<ComingSoonBloc>().add(
                                  GetUpcomingMoviesEvent(1),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is ComingSoonEmpty) {
                      return Center(
                        child: Text(
                          'No upcoming movies found',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                          ),
                        ),
                      );
                    }
                    if (state is ComingSoonLoaded) {
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        itemCount:
                            state.movies.length + (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.movies.length) {
                            return _shimmerCard();
                          }
                          final movie = state.movies[index];
                          final String? imageUrl =
                              movie.backdropPath != null &&
                                  movie.backdropPath!.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w780${movie.backdropPath}'
                              : movie.posterPath != null &&
                                    movie.posterPath!.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                              : null;

                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: w * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(w * 0.025),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(w * 0.025),
                                    topRight: Radius.circular(w * 0.025),
                                  ),
                                  child: imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          width: double.infinity,
                                          height: w * 0.55,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return _imagePlaceholder();
                                          },
                                          errorWidget: (context, url, error) {
                                            return _imagePlaceholder();
                                          },
                                        )
                                      : _imagePlaceholder(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: w * 0.03,
                                    right: w * 0.04,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.notifications_outlined,
                                            color: Colors.white,
                                            size: w * 0.06,
                                          ),
                                          SizedBox(height: w * 0.01),
                                          Text(
                                            'Remind Me',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: w * 0.028,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: w * 0.05),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.share_outlined,
                                            color: Colors.white,
                                            size: w * 0.06,
                                          ),
                                          SizedBox(height: w * 0.01),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: w * 0.028,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: w * 0.04,
                                    right: w * 0.04,
                                    top: w * 0.04,
                                  ),
                                  child: Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: w * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: w * 0.04,
                                    right: w * 0.04,
                                    top: w * 0.015,
                                  ),
                                  child: Text(
                                    movie.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: w * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: w * 0.04,
                                    right: w * 0.04,
                                    top: w * 0.02,
                                  ),
                                  child: Wrap(
                                    spacing: w * 0.02,
                                    children: [
                                      Text(
                                        'Movie',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: w * 0.03,
                                        ),
                                      ),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.03,
                                        ),
                                      ),
                                      Text(
                                        'TMDB',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: w * 0.03,
                                        ),
                                      ),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.03,
                                        ),
                                      ),
                                      Text(
                                        movie.voteAverage.toStringAsFixed(1),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: w * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: w * 0.04,
                                    right: w * 0.04,
                                    top: w * 0.02,
                                    bottom: w * 0.05,
                                  ),
                                  child: Text(
                                    movie.overview != null &&
                                            movie.overview!.isNotEmpty
                                        ? movie.overview!
                                        : 'No description available.',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: w * 0.033,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: w * 0.55,
      color: Colors.grey.shade800,
      child: Icon(Icons.movie, color: Colors.white54, size: w * 0.15),
    );
  }
}

Widget _shimmerCard() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: w * 0.05),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(w * 0.025),
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: w * 0.55,
            color: Colors.white,
          ),
          SizedBox(height: w * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(width: w * 0.15, height: w * 0.06, color: Colors.white),
              SizedBox(width: w * 0.05),
              Container(width: w * 0.12, height: w * 0.06, color: Colors.white),
              SizedBox(width: w * 0.04),
            ],
          ),
          SizedBox(height: w * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              width: w * 0.25,
              height: w * 0.035,
              color: Colors.white,
            ),
          ),
          SizedBox(height: w * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              width: w * 0.65,
              height: w * 0.06,
              color: Colors.white,
            ),
          ),
          SizedBox(height: w * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Container(
              width: w * 0.45,
              height: w * 0.035,
              color: Colors.white,
            ),
          ),
          SizedBox(height: w * 0.025),
          Padding(
            padding: EdgeInsets.only(
              left: w * 0.04,
              right: w * 0.04,
              bottom: w * 0.05,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: w * 0.035,
                  color: Colors.white,
                ),
                SizedBox(height: w * 0.015),
                Container(
                  width: double.infinity,
                  height: w * 0.035,
                  color: Colors.white,
                ),
                SizedBox(height: w * 0.015),
                Container(
                  width: w * 0.75,
                  height: w * 0.035,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
