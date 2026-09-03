import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';
import 'package:movie_discovery_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:movie_discovery_app/features/search/presentation/bloc/search_event.dart';
import 'package:movie_discovery_app/features/search/presentation/bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () {
        if (!mounted) return;
        context.read<SearchBloc>().add(
          SearchMovieEvent(value.trim()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: searchController,
              builder: (context, value, child) {
                return Container(
                  width: double.infinity,
                  height: w * 0.13,
                  color: Colors.grey.shade900,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.04),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: w * 0.065,
                      ),
                      SizedBox(width: w * 0.02),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: _onSearchChanged,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.035,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Search for a show, movie, genre, etc.',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: w * 0.035,
                            ),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                      if (value.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            searchController.clear();
                            _debounce?.cancel();
                            context.read<SearchBloc>().add(
                              SearchMovieEvent(''),
                            );
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: w * 0.055,
                          ),
                        ),
                      SizedBox(width: w * 0.03),
                      Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: w * 0.06,
                      ),
                      SizedBox(width: w * 0.04),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: w * 0.03),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: w * 0.03,
                  bottom: w * 0.03,
                ),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    final bool isSearching =
                        state is SearchLoaded ||
                        state is SearchLoading ||
                        state is SearchEmpty ||
                        state is SearchError;

                    return Text(
                      isSearching ? 'Search Results' : 'Top Searches',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return _buildTopSearches();
                  }
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (state is SearchEmpty) {
                    return Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04,
                        ),
                      ),
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.08,
                        ),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: w * 0.035,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is SearchLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        final String? posterUrl =
                            movie.posterPath != null &&
                                    movie.posterPath!.isNotEmpty
                                ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                                : null;

                        return Container(
                          height: w * 0.22,
                          margin: EdgeInsets.only(
                            left: w * 0.04,
                            right: w * 0.04,
                            bottom: w * 0.03,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(
                              w * 0.02,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    w * 0.02,
                                  ),
                                  bottomLeft: Radius.circular(
                                    w * 0.02,
                                  ),
                                ),
                                child: SizedBox(
                                  width: w * 0.20,
                                  height: w * 0.22,
                                  child: posterUrl != null
                                      ? Image.network(
                                          posterUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return _posterPlaceholder();
                                              },
                                        )
                                      : _posterPlaceholder(),
                                ),
                              ),
                              SizedBox(width: w * 0.03),
                              Expanded(
                                child: Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: w * 0.02),
                              Container(
                                width: w * 0.10,
                                height: w * 0.10,
                                margin: EdgeInsets.only(
                                  right: w * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: w * 0.055,
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
    );
  }

  Widget _buildTopSearches() {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          height: w * 0.22,
          margin: EdgeInsets.only(
            left: w * 0.04,
            right: w * 0.04,
            bottom: w * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(
              w * 0.02,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * 0.02),
                  bottomLeft: Radius.circular(w * 0.02),
                ),
                child: SizedBox(
                  width: w * 0.20,
                  height: w * 0.22,
                  child: Container(
                    color: Colors.grey.shade800,
                    child: Icon(
                      Icons.movie,
                      color: Colors.white54,
                      size: w * 0.08,
                    ),
                  ),
                ),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Text(
                  'Movie Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: w * 0.02),
              Container(
                width: w * 0.10,
                height: w * 0.10,
                margin: EdgeInsets.only(
                  right: w * 0.03,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: w * 0.055,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      color: Colors.grey.shade800,
      child: Icon(
        Icons.movie,
        color: Colors.white54,
        size: w * 0.08,
      ),
    );
  }
}