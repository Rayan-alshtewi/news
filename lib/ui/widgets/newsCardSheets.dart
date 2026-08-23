import 'package:flutter/material.dart';
import 'package:news/utils/app_routs.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_style.dart';
class Newscardsheets extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Padding(
    padding:EdgeInsets.all(8) ,
    child:  Container(
      padding:EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.asset(
              AppAssets.image1,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "A 40-year-old man has fallen approximately 200 feet to his death while canyoneering with three "
                "others at Zion National Park in Utah, authorities confirmed."
                "\r\nThe incident occurred on Saturday when the… [+1529 chars]",
            style: AppTextStyle.medium14black,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouts.newsScreenDetails);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                textStyle:AppTextStyle.bold16white ,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8))
            ),
            child: const Text("View Full Articel"),
          ),
        ],
      ),
    ),
  );
}
}