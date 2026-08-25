
import 'package:dio/dio.dart';
import 'package:news/models/news_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsService {
  final Dio dio=Dio();

  Future <List<NewsModel>> getNews(int page) async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters:{
         'country':'us',
          'page':page,
          'pageSize':8,
          'apiKey':dotenv.env['API_KEY'],
      }
    );
    final articles=response.data['articles'] as List;
    final news=articles.map((article)=>NewsModel.fromJson(article)).toList();
    return news;
  }
}
