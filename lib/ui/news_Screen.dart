import 'package:flutter/material.dart';
import 'package:news/ui/widgets/newsCardSheets.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/app_colors.dart';
import '../utils/app_text_style.dart';
import 'package:news/ui/widgets/newsCard.dart';
import 'package:news/models/news_model.dart';
import 'package:news/services/news_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isSearching = false;
  String? selectedSource;
  final NewsService newsService = NewsService();
  late Future<List<NewsModel>> newsFuture;

  int currentPage = 1;
  List<NewsModel> allNews = [];
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  final TextEditingController searchController = TextEditingController();
  List<NewsModel> searchedNews = [];
  @override
  void initState() {
    super.initState();
    newsFuture = newsService.getNews(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMoreNews();
      }
    });

    searchController.addListener(() {
      final query = searchController.text.trim().toLowerCase();

      if (query.isEmpty) {
        setState(() {
          searchedNews = [];
        });
        return;
      }

      setState(() {
        searchedNews = allNews.where((item) {
          return item.title?.toLowerCase().contains(query) ?? false;
        }).toList();
      });
    });
  }
  Future<void> loadMoreNews() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    final newNews = await newsService.getNews(currentPage);
    if (newNews.isEmpty) {
      isLoadingMore = false;
      return;
    }
    allNews.addAll(newNews);
    isLoadingMore = false;
    setState(() {});
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: isSearching
            ? null
            :  IconButton(
          onPressed: () {
          },
          icon: Icon(Icons.menu, color: AppColors.white),
        ),
        title:
        isSearching
            ? Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),

              Icon(
                Icons.search,
                color: AppColors.white,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  style: AppTextStyle.medium14white,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: AppTextStyle.medium20white,
                    border: InputBorder.none,
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        )
            :Text("General", style: AppTextStyle.medium20white),
        centerTitle: true,
        actions:isSearching
            ? []
            : [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
              icon: Icon(Icons.search, color: AppColors.white),
          ),
        ],
      ),

      body:  FutureBuilder<List<NewsModel>>(
      future:newsFuture,
      builder: (context, snapshot){

      if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
      child: CircularProgressIndicator(),
      );
    }

      if (snapshot.hasError) {
      return Center(
      child: Text(
      "Something went wrong",
      style: AppTextStyle.medium14white,
        ),
      );
    }

      final news = snapshot.data ?? [];
      if (allNews.isEmpty) {
        allNews.addAll(news);
      }

      final sources = allNews
          .map((item) => item.source)
          .where((source) => source != null && source.isNotEmpty)
          .toSet()
          .toList();

      final allSources = ['All', ...sources];

      final sourceFilteredNews = selectedSource == null
          ? allNews
          : allNews
          .where((item) => item.source == selectedSource)
          .toList();

      final filteredNews = searchController.text.trim().isEmpty
          ? sourceFilteredNews
          : sourceFilteredNews.where((item) {
        final query = searchController.text.trim().toLowerCase();

        return item.title?.toLowerCase().contains(query) ?? false;
      }).toList();

      return ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(8),
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: allSources.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 20);
              },
              itemBuilder: (context, index) {
                final source = allSources[index];
                final isSelected = source == 'All'
                    ? selectedSource == null
                    : source == selectedSource;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSource = source == 'All' ? null : source;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      border: isSelected
                          ? const Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      )
                          : null,
                    ),
                    child: Text(
                      source!,
                      style: isSelected
                          ? AppTextStyle.bold16white
                          : AppTextStyle.medium14white,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          ...filteredNews.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: NewsCard(
                news: item,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Newscardsheets( news: item);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
      },
      ),
    );
  }

}

