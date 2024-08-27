import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'dart:convert';
import 'package:news_app/secret.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    logger.i('Starting getNews function');

    String url =
        "https://newsapi.org/v2/top-headlines?country=br&apiKey=${apiKey}";

    var response = await http.get(Uri.parse(url));
    logger.i('Response: ${response.body}');
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      logger.i('Response: status ok');
      jsonData["articles"].forEach((element) {
        Article article = Article(
            title: element['title'],
            author: element['author'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"]);
        news.add(article);
        logger.i('Article: $article');
        news.add(article);
      });
    }
  }
}

class NewsForCategorie {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    String url =
        "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['title'] != null &&
            element['author'] != null &&
            element['content'] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element["content"]);
          news.add(article);
        }
      });
    }
  }
}
