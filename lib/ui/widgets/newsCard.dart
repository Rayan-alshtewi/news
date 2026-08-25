import 'package:flutter/material.dart';

import '../../models/news_model.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_text_style.dart';
class NewsCard extends StatelessWidget {
  final VoidCallback onTap;
  final NewsModel news;
  const NewsCard({super.key,required this.onTap, required this.news,});

  String getTimeAgo(String? publishedAt) {
    if (publishedAt == null) {
      return "Unknown time";
    }

    final publishedTime = DateTime.parse(publishedAt);
    final difference = DateTime.now().difference(publishedTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  Widget buildNewsImage() {
    if (news.urlToImage == null || news.urlToImage!.isEmpty) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: Image.network(
        news.urlToImage!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: onTap,
        child: Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNewsImage(),
          SizedBox(height: 10),
          Text(
            news.title??'No title',
            style: AppTextStyle.bold16white,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("By :${news.author??'Unknown'}", style: AppTextStyle.medium12gray),
              Spacer(),
              Text( getTimeAgo(news.publishedAt) , style: AppTextStyle.medium12gray),
            ],
          ),
        ],
      ),
    ));
  }
}


