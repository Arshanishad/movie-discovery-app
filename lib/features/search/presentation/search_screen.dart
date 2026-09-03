import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: w * 0.13,
              color: Colors.grey,
              child: Row(
                children: [
                  SizedBox(width: w * 0.04),

                  Icon(Icons.search, color: Colors.white, size: w * 0.065),

                  SizedBox(width: w * 0.03),

                  Expanded(
                    child: Text(
                      "Search for a show, movie, genre, etc.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.035,
                      ),
                    ),
                  ),

                  Icon(Icons.mic, color: Colors.white, size: w * 0.06),

                  SizedBox(width: w * 0.04),
                ],
              ),
            ),

            SizedBox(height: w * 0.03),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.03, bottom: w * 0.03),
                child: Text(
                  "Top Searches",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
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
                      borderRadius: BorderRadius.circular(w * 0.02),
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
                            child: Image.asset(
                              ImageConstants.bannerImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: w * 0.03),

                        Expanded(
                          child: Text(
                            "Movie Name",
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
                          margin: EdgeInsets.only(right: w * 0.03),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
