import 'package:dartz/dartz.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/article_repository.dart';

class GetArticlesByParam {
  final ArticleRepository articleRepository;
  GetArticlesByParam(this.articleRepository);

  Future<Either<Failur, List<Article>>> execute(String query) async {
    return await articleRepository.getArticlesByParam(query);
  }
}
