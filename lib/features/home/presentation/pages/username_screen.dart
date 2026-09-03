import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
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
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.20, top: w * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(ImageConstants.netFlixLogo),
                    width: w * 0.35,
                  ),
                  SizedBox(width: w * 0.19),
                  Icon(Icons.edit, color: Colors.white, size: w * 0.06),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: w * 0.2,
                  right: w * 0.2,
                  top: w * 0.3,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 35,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Image.asset(usernames[index]["image"]),
                        Text(
                          usernames[index]["text"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: w * 0.05),
            Transform.translate(
              offset: const Offset(0, -180),
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: w * 0.13,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(ImageConstants.plusIcon),
                    ),
                    SizedBox(height: w * 0.03),
                    Text(
                      'Add Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w400,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
