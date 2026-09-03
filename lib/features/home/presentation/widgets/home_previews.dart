import 'package:flutter/material.dart';
import 'package:movie_discovery_app/core/constants/Image_constants.dart';
import 'package:movie_discovery_app/core/constants/constants.dart';

class HomePreviews extends StatelessWidget {
  const HomePreviews({super.key});

  @override
  Widget build(BuildContext context) {
    final previewImages = [
      ImageConstants.previewImage1,
      ImageConstants.previewImage1,
      ImageConstants.previewImage1,
      ImageConstants.previewImage1,
      ImageConstants.previewImage1,
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: w * 0.02,
        bottom: w * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: w * 0.04,
              bottom: w * 0.03,
            ),
            child: Text(
              'Previews',
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: w * 0.30,
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: w * 0.04,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: previewImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: w * 0.27,
                  margin: EdgeInsets.only(
                    right: w * 0.03,
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      previewImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}