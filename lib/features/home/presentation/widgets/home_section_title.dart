import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';

class HomeSectionTitle extends StatelessWidget {
  final String title;
  const HomeSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: w * 0.04,
        bottom: w * 0.02,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: w * 0.055,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}