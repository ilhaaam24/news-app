import 'dart:convert';

import 'package:news_app/core/exception.dart';
import 'package:news_app/core/shared_values.dart';
import 'package:news_app/features/article/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDatasource {
  Future<List<ArticleModel>> getArticles(
    int page, {
    String? query,
    String category = "general",
  });
  Future<List<ArticleModel>> getArticleByCategory({
    int page = 1,
    String category = "general",
  });
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDatasource {
  http.Client client;

  ArticleRemoteDataSourceImpl(this.client);
  @override
  Future<List<ArticleModel>> getArticles(
    int page, {
    String? query,
    String category = "general",
  }) async {
    final url = Uri.parse(
      "https://gnews.io/api/v4/top-headlines"
      "?apikey=$apiKey"
      "&country=id"
      "&category=$category"
      "&page=$page"
      "${query != null ? "&q=$query" : ""}",
    );

    final res = await client.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body)['articles'] as List;
      return data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } else if (res.statusCode == 404) {
      throw EmptyException("Data not found");
    } else if (res.statusCode == 500) {
      throw ServerException("Internal server error");
    } else {
      throw GeneralException('Failed to load data');
    }
  }

  @override
  Future<List<ArticleModel>> getArticleByCategory({
    int page = 1,
    String category = "general",
  }) async {
    final url = Uri.parse(
      "https://gnews.io/api/v4/top-headlines"
      "?apikey=$apiKey"
      "&country=id"
      "&category=$category"
      "&page=$page"
      "&lang=id",
    );

    final res = await client.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body)['articles'] as List;
      return data
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } else if (res.statusCode == 404) {
      throw EmptyException("Data not found");
    } else if (res.statusCode == 500) {
      throw ServerException("Internal server error");
    } else {
      throw GeneralException('Failed to load data');
    }
  }
}
