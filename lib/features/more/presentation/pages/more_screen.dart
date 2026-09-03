import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final List<Map<String, dynamic>> usernames = [
    {"image": ImageConstants.emanaloUsername, "text": "Emelano"},
    {"image": ImageConstants.onyekaUsername, "text": "Onyeka"},
    {"image": ImageConstants.thelmaUsername, "text": "Thelma"},
    {"image": ImageConstants.kidsUsername, "text": "Kids"},
  ];

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.greyColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Palette.blackColor,

              child: SafeArea(
                bottom: false,

                child: Padding(
                  padding: EdgeInsets.only(
                    top: w * 0.02,
                    left: w * 0.04,
                    bottom: w * 0.04,
                  ),

                  child: Column(
                    children: [
                      SizedBox(
                        height: w * 0.38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: usernames.length + 1,
                          itemBuilder: (context, index) {
                            final bool isAddItem = index == usernames.length;
                            final bool isFirstItem = index == 0;
                            return Padding(
                              padding: EdgeInsets.only(right: w * 0.03),
                              child: SizedBox(
                                width: w * 0.25,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: w * 0.25,
                                      height: w * 0.30,

                                      child: Align(
                                        alignment: Alignment.bottomCenter,

                                        child: SizedBox(
                                          width: w * 0.25,

                                          height: isFirstItem
                                              ? w * 0.30
                                              : w * 0.25,

                                          child: isAddItem
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          w * 0.02,
                                                        ),
                                                  ),

                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        w * 0.025,
                                                      ),

                                                  child: Image.asset(
                                                    usernames[index]["image"],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: w * 0.02),

                                    if (!isAddItem)
                                      Text(
                                        usernames[index]["text"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.035,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: w * 0.05),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.edit, color: Colors.white, size: w * 0.06),

                          SizedBox(width: w * 0.02),

                          Text(
                            "Manage Profiles",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: w * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(ImageConstants.boxDotIcon, width: w * 0.06),

                  SizedBox(width: w * 0.03),

                  Text(
                    "Tell friends about Netflix.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis "
                "non accumsan accumsan quis. Massa,",
                style: TextStyle(color: Colors.white, fontSize: w * 0.03),
              ),
            ),
            SizedBox(height: w * 0.06),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  textAlign: TextAlign.start,
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.03,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: w * 0.04),

            Padding(
              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.03),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: w * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(w * 0.01),
                      ),
                    ),
                  ),

                  SizedBox(width: w * 0.03),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: w * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.01),
                      ),
                      child: Center(
                        child: Text(
                          "Copy Link",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w * 0.037,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.whatsappIcon,
                  width: w * 0.09,
                  height: w * 0.09,
                ),

                Container(width: 1, height: w * 0.07, color: Colors.white),

                Image.asset(
                  ImageConstants.facebookIcon,
                  width: w * 0.09,
                  height: w * 0.09,
                ),

                Container(width: 1, height: w * 0.07, color: Colors.white),

                Image.asset(
                  ImageConstants.gmailIcon,
                  width: w * 0.11,
                  height: w * 0.11,
                ),

                Container(width: 1, height: w * 0.07, color: Colors.white),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ImageConstants.moreIcon,
                      width: w * 0.10,
                      height: w * 0.08,
                    ),

                    Text(
                      "More",
                      style: TextStyle(color: Colors.white, fontSize: w * 0.03),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: w * 0.57,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: w * 0.05,
                      left: w * 0.05,
                      right: w * 0.05,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.done, color: Colors.white, size: w * 0.07),

                        SizedBox(width: w * 0.03),

                        Text(
                          "My List",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: w * 0.04),

                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.06, top: w * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App Settings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: w * 0.02),

                        Text(
                          "Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: w * 0.02),

                        Text(
                          "Help",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: w * 0.02),

                        Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
