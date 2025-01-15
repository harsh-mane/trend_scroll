import 'dart:convert';
import 'dart:developer';

import 'package:trend_scroll/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews({final String q = 'sports'}) async {
    final now = DateTime.now();
    // now.subtract(const Duration(days: -1));
    String url =
        "https://newsapi.org/v2/everything?q=$q&from=${now.year}-${now.month}-${now.day - 1}&sortBy=publishedAt&apiKey=12d2662bebe6473e843812edb939e7bc";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    log(url, name: 'URL');
    log('$jsonData', name: 'GetNews');

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
