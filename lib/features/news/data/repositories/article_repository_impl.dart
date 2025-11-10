import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/news/data/datasources/remote_datasource.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final ArticleRemoteDataSourceImpl articleRemoteDataSourceImpl;

  ArticleRepositoryImpl({required this.articleRemoteDataSourceImpl});

  @override
  Future<Either<Failur, List<Article>>> getArticles(
    int page, {
    String? query,
    String category = "general",
  }) async {
    try {
      var resultArticle = await articleRemoteDataSourceImpl.getArticles(
        page,
        query: query,
        category: category,
      );
      return Right(resultArticle);
    } catch (e) {
      return left(Failur());
    }
  }
}
