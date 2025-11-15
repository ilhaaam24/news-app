import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/article/domain/entities/article.dart';
import 'package:news_app/features/article/domain/repositories/article_repository.dart';

class GetArticleByCategory {
  final ArticleRepository articleRepository;
  GetArticleByCategory(this.articleRepository);

  Future<Either<Failur, List<Article>>> execute(
    String category, {
    int page = 1,
  }) async {
    return await articleRepository.getAllArticleByCategory(
      category,
      page: page,
    );
  }
}
