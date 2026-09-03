import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class UserNameScreen extends StatelessWidget {
  const UserNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.15, top: w * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(ImageConstants.netFlixLogo)),
                  SizedBox(width: w * 0.19),
                  // Image.asset(ImageConstants.editIcon, width: w * 0.35),
                  Icon(Icons.edit, color: Colors.white, size: w * 0.08),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
