import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: h * 0.45,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.bannerImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: h * 0.05,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  ImageConstants.netflixIcon,
                  width: w * 0.08,
                ),
                Text(
                  'TV Shows',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.04,
                  ),
                ),
                Text(
                  'Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.04,
                  ),
                ),
                Text(
                  'My List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}