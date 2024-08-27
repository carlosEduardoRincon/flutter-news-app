import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({required this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);

    newslist = news.news;
    logger.i('TAMANHO DO ARRAY: ${newslist[0].title}');

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.share,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: newslist.length,
                  itemBuilder: (context, index) {
                    logger.i("Tamanho: ${newslist[index]}");
                    logger.i("Title: ${newslist[index].title}");
                    logger.i("Conteúdo: ${newslist[index].content}");
                    return NewsFile(
                      title: newslist[index].title ?? "No title",
                      content: newslist[index].content ?? "No content",
                    );
                  }),
            ),
    );
  }
}
