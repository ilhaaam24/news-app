import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:news_app/core/exception.dart';
import 'package:news_app/core/shared_values.dart';
import 'package:news_app/features/news/data/datasources/remote_datasource.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

import 'article_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ArticleRemoteDatasource>(),
  MockSpec<http.Client>(),
])
void main() {
  var remoteDataSource = MockArticleRemoteDatasource();
  http.Client client = MockClient();
  var remoteDataSourceImpl = ArticleRemoteDataSourceImpl(client);

  int page = 1;
  String query = "saham";
  String category = "general";

  Uri urlGetArticle = Uri.parse(
    "https://gnews.io/api/v4/top-headlines"
    "?apikey=$apiKey"
    "&country=id"
    "&category=$category"
    "&page=$page"
    "&q=$query",
  );

  Map<String, dynamic> jsonResponse = {
    "id": "1",
    "title": "Sample Title $query",
    "description": "Sample Description",
    "content": "Sample Content",
    "url": "http://example.com",
    "image": "http://example.com/image.jpg",
    "publishedAt": "2024-06-01T00:00:00Z",
    "source": {
      "id": "source1",
      "name": "Source Name",
      "url": "http://source.com",
    },
  };

  final ArticleModel article = ArticleModel.fromJson(jsonResponse);

  group("Remote Data Source", () {
    group("get article by param", () {
      test(" berhasil", () async {
        when(
          remoteDataSource.getArticles(page, query: query, category: category),
        ).thenAnswer((_) async => [article]);

        try {
          var res = await remoteDataSource.getArticles(
            page,
            query: query,
            category: category,
          );
          expect(res, [article]);
          // testing berhasil
          // pasti terjadi
        } catch (e) {
          // testing gagal
          // pasti tidak terjadi
          fail("Expected successful fetch, but got exception: $e");
        }
      });
      test(" gagal", () async {
        when(
          remoteDataSource.getArticles(page, query: query, category: category),
        ).thenThrow(Exception());

        try {
          await remoteDataSource.getArticles(
            page,
            query: query,
            category: category,
          );
          fail("tidak terjadi");
          // testing berhasil
          // pasti tidak terjadi
        } catch (e) {
          // testing gagal
          // pasti terjadi
          expect(e, isException);
        }
      });
    });
  });
  group("Remote data source implementation", () {
    group('get article by param', () {
      test(" Berhasil - 200", () async {
        when(client.get(urlGetArticle)).thenAnswer(
          (_) async => http.Response(
            json.encode({
              "articles": [jsonResponse],
            }),
            200,
          ),
        );

        try {
          var res = await remoteDataSourceImpl.getArticles(
            page,
            query: query,
            category: category,
          );

          print(res);
          expect(res, [article]);
        } catch (e) {
          fail("tidak terjadi");
        }
      });
      test(" Gagal - 404", () async {
        when(
          client.get(urlGetArticle),
        ).thenThrow(EmptyException("Data not found"));

        try {
          var res = await remoteDataSourceImpl.getArticles(
            page,
            query: query,
            category: category,
          );

          fail("tidak terjadi");
        } catch (e) {
          expect(e, isException);
        }
      });
      test(" Gagal - 500", () async {
        when(
          client.get(urlGetArticle),
        ).thenThrow(EmptyException("Internal server error"));

        try {
          var res = await remoteDataSourceImpl.getArticles(
            page,
            query: query,
            category: category,
          );

          fail("tidak terjadi");
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });
}
