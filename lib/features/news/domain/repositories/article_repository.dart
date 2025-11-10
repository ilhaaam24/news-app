import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failur, List<Article>>> getArticles(
    int page, {
    String? query,
    String category = "general",
  });
}
