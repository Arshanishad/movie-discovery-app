import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_event.dart';
import 'package:movie_discovery_app/features/home/presentation/bloc/home_state.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/home_section_title.dart';
import 'package:movie_discovery_app/features/home/presentation/widgets/movie_card.dart';

class TopRatedSection extends StatefulWidget {
  const TopRatedSection({super.key});

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<HomeBloc>().add(LoadMoreTopRatedMoviesEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _loading();
        }

        if (state is HomeError) {
          return _error(context, state.message);
        }

        if (state is HomeLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeSectionTitle(title: 'Top Rated'),

              SizedBox(
                height: h * 0.35,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: w * 0.04),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      state.trendingMovies.length +
                      (state.isTrendingLoadingMore ? 2 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.trendingMovies.length) {
                      return _shimmerCard();
                    }
                    return MovieCard(movie: state.topRatedMovies[index]);
                  },
                ),
              ),

              SizedBox(height: w * 0.08),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _loading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: w * 0.04, bottom: w * 0.03),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              width: w * 0.30,
              height: w * 0.055,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.01),
              ),
            ),
          ),
        ),

        SizedBox(
          height: h * 0.35,
          child: ListView.builder(
            padding: EdgeInsets.only(left: w * 0.04),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return _shimmerCard();
            },
          ),
        ),

        SizedBox(height: w * 0.08),
      ],
    );
  }

  Widget _shimmerCard() {
    return Padding(
      padding: EdgeInsets.only(right: w * 0.03),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade700,
        child: Container(
          width: w * 0.30,
          height: h * 0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.025),
          ),
        ),
      ),
    );
  }

  Widget _error(BuildContext context, String message) {
    return SizedBox(
      height: h * 0.20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.white70, size: w * 0.08),

            SizedBox(height: w * 0.02),

            Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: w * 0.01),

            Text(
              message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white54, fontSize: w * 0.028),
            ),

            SizedBox(height: w * 0.025),

            SizedBox(
              height: w * 0.09,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<HomeBloc>().add(GetHomeMoviesEvent());
                },
                icon: Icon(Icons.refresh, size: w * 0.045),
                label: Text('Retry', style: TextStyle(fontSize: w * 0.03)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
