import 'package:flutter/material.dart';
import 'package:news/utils/app_routs.dart';

import '../../models/news_model.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
class Newscardsheets extends StatelessWidget {
  final NewsModel news;
  const Newscardsheets({
    super.key,
    required this.news,
  });
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
            child: news.urlToImage != null && news.urlToImage!.isNotEmpty
                ? Image.network(
              news.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.gray,
                );
              },
            )
                : Container(
              height: 200,
              width: double.infinity,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            news.description ?? "",
            style: AppTextStyle.medium14black,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (news.url == null || news.url!.isEmpty) return;

              final Uri url = Uri.parse(news.url!);

              await launchUrl(
                url,
                mode: LaunchMode.inAppWebView,
              );
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