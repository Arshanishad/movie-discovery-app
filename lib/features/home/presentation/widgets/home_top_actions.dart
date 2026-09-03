import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class HomeTopActions extends StatelessWidget {
  const HomeTopActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
        vertical: w * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: w * 0.07,
              ),
              SizedBox(height: w * 0.01),
              Text(
                'My List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.035,
                ),
              ),
            ],
          ),
          Container(
            height: w * 0.11,
            width: w * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                w * 0.02,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Palette.blackColor,
                  size: w * 0.07,
                ),
                SizedBox(width: w * 0.01),
                Text(
                  'Play',
                  style: TextStyle(
                    color: Palette.blackColor,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: w * 0.07,
              ),
              SizedBox(height: w * 0.01),
              Text(
                'Info',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.035,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}