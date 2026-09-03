import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List previewImages = [
    ImageConstants.previewImage1,
    ImageConstants.previewImage1,
    ImageConstants.previewImage1,
    ImageConstants.previewImage1,
    ImageConstants.previewImage1,
  ];
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
                  Padding(
                    padding: EdgeInsetsGeometry.all(w * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(ImageConstants.netflixIcon),
                        Text(
                          "Tv Shows ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.05,
                          ),
                        ),
                        Text(
                          "Movies",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.05,
                          ),
                        ),
                        Text(
                          "My List  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: w * 0.07,
                  width: w * 0.07,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOP",
                          style: TextStyle(
                            fontSize: w * 0.02,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            fontSize: w * 0.02,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: w * 0.02),
                Text(
                  "#2 in Nigeria Today",
                  style: TextStyle(color: Colors.white, fontSize: w * 0.04),
                ),
              ],
            ),
            SizedBox(height: w * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: w * 0.07),
                      Text(
                        "My List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: w * 0.1,
                        width: w * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.02),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Palette.blackColor,
                              size: w * 0.08,
                            ),
                            Text(
                              "Play",
                              style: TextStyle(
                                fontSize: w * 0.04,
                                color: Palette.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: w * 0.08,
                      ),
                      Text(
                        "Info",
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
            Padding(
              padding: EdgeInsets.only(left: w * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Previews",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.07,
                    ),
                  ),
                  SizedBox(
                    height: w * 0.32,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: previewImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: w * 0.02),
                          width: w * 0.30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            previewImages[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
