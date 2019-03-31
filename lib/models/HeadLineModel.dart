import 'dart:io';
import 'package:news_page/models/headNews.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HeadLineModel extends Model {
  File _image = null;
  File get getImage => _image;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Articles> _news;
  List<Articles> get getNews => _news;
  void fetchNews() async {
    _isLoading = true;
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=4fb22a82484c49798869b45c01f524c9');
    var responseJson = json.decode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(responseJson);
    _news = newsResponse.articles;
    _isLoading = false;
    notifyListeners();
  }
}
