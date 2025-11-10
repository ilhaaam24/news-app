import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/article_repository.dart';

class GetArticles {
  final ArticleRepository articleRepository;
  GetArticles(this.articleRepository);

  Future<Either<Failur, List<Article>>> execute(int page) async {
    return await articleRepository.getArticles(page);
  }
}
