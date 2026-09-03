import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';
import 'package:movie_discovery_app/core/theme/palette.dart';
import 'package:movie_discovery_app/features/navigation/presentation/pages/navbar.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final List<Map<String, dynamic>> usernames = [
    {
      "image": ImageConstants.emanaloUsername,
      "text": "Emelano",
    },
    {
      "image": ImageConstants.onyekaUsername,
      "text": "Onyeka",
    },
    {
      "image": ImageConstants.thelmaUsername,
      "text": "Thelma",
    },
    {
      "image": ImageConstants.kidsUsername,
      "text": "Kids",
    },
  ];

  void _selectProfile(String username) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Navbar(
          username: username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: w * 0.08,
                left: w * 0.20,
                right: w * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstants.netFlixLogo,
                    width: w * 0.35,
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: w * 0.06,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  left: w * 0.20,
                  right: w * 0.20,
                  top: w * 0.15,
                  bottom: w * 0.02,
                ),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: w * 0.08,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.72,
                ),
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  final profile = usernames[index];
                  return GestureDetector(
                    onTap: () {
                      _selectProfile(
                        profile["text"] as String,
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Image.asset(
                            profile["image"],
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: w * 0.02,
                        ),
                        Text(
                          profile["text"],
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
            Padding(
              padding: EdgeInsets.only(
                bottom: h * 0.05,
              ),
              child: GestureDetector(
                onTap: () {
                },
                child: Column(
                  children: [
                    Container(
                      width: w * 0.13,
                      height: w * 0.13,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          w * 0.025,
                        ),
                        child: Image.asset(
                          ImageConstants.plusIcon,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.025,
                    ),
                    Text(
                      'Add Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w400,
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