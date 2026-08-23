import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_text_style.dart';
class NewsCard extends StatelessWidget {
  final VoidCallback onTap;
  const NewsCard({super.key,required this.onTap,});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: onTap,
        child: Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
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
            "40-year-old man falls 200 feet to his death while canyoneering at national park",
            style: AppTextStyle.bold16white,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("By : Jon Haworth", style: AppTextStyle.medium12gray),
              Spacer(),
              Text("15 minutes ago", style: AppTextStyle.medium12gray),
            ],
          ),
        ],
      ),
    ));
  }
}
