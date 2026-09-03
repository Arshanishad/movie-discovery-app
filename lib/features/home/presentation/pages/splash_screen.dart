import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.netFlixLogo,
              width: w * 1,
              height: w * 1,
            ),
          ],
        ),
      ),
    );
  }
}
