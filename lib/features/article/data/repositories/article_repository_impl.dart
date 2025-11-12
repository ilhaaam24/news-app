import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/article/data/datasources/remote_datasource.dart';
import 'package:news_app/features/article/domain/entities/article.dart';
import 'package:news_app/features/article/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final ArticleRemoteDatasource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  @override
  Future<Either<Failur, List<Article>>> getArticles(
    int page, {
    String? query,
    String category = "general",
  }) async {
    try {
      var resultArticle = await articleRemoteDataSource.getArticles(
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
