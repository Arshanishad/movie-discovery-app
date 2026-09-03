import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: w * 0.03, left: w * 0.065),
                child: Text(
                  "Smart Downloads",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: w * 0.07),
              Padding(
                padding: EdgeInsets.only(left: w * 0.02),
                child: Text(
                  textAlign: TextAlign.start,
                  "Introducing Downloads For You",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: w * 0.03),
              Padding(
                padding: EdgeInsets.only(left: w * 0.02),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis "
                  "non accumsan accumsan quis. Massa, id ut ipsum aliquam enim "
                  "non posuere pulvinar diam.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: w * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: w * 0.06),
                    width: w * 0.5,
                    height: w * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.greyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.04),
              SizedBox(
                width: double.infinity,
                height: w * 0.12,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(w * 0.02),
                    ),
                    backgroundColor: Palette.blueColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    "SETUP",
                    style: TextStyle(fontSize: w * 0.04, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: w * 0.07),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: w * 0.65,
                  height: w * 0.12,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(w * 0.01),
                      ),
                      backgroundColor: Palette.greyColor,
                    ),
                    onPressed: () {},
                    child: FittedBox(
                      child: Text(
                        "Find Something to Download",
                        style: TextStyle(
                          fontSize: w * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
