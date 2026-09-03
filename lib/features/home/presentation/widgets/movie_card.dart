
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/features/home/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl =
        movie.posterPath != null && movie.posterPath!.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : null;

    return Container(
      width: w * 0.32,
      margin: EdgeInsets.only(
        right: w * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(
          w * 0.025,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                w * 0.025,
              ),
            ),
            child: posterUrl != null
                ? CachedNetworkImage(
                    imageUrl: posterUrl,
                    width: double.infinity,
                    height: h * 0.30,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return _shimmerPlaceholder();
                    },
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) {
                      return _errorPlaceholder();
                    },
                  )
                : _errorPlaceholder(),
          ),
          Padding(
            padding: EdgeInsets.all(
              w * 0.02,
            ),
            child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: double.infinity,
        height: h * 0.30,
        color: Colors.white,
      ),
    );
  }

  Widget _errorPlaceholder() {
    return Container(
      width: double.infinity,
      height: h * 0.30,
      color: Colors.grey.shade800,
      child: Center(
        child: Icon(
          Icons.movie_outlined,
          color: Colors.white54,
          size: w * 0.10,
        ),
      ),
    );
  }
}
