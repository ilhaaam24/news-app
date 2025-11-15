import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/article/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failur, List<Article>>> getArticles(
    int page, {
    String category = "general",
  });
  Future<Either<Failur, List<Article>>> getAllArticleByCategory(
    String category, {
    int page = 1,
  });
}
