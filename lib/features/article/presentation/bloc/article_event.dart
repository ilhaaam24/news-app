part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {}

class GetAllArticle extends ArticleEvent {
  final int page;
  GetAllArticle(this.page);

  @override
  List<Object?> get props => [page];
}

class GetDetailarticleEvent extends ArticleEvent {
  final int id;
  GetDetailarticleEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetAllArticleByCategoryEvent extends ArticleEvent {
  final String category;
  GetAllArticleByCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}
class GetArticleByQueryEvent extends ArticleEvent {
  final String query;
  GetArticleByQueryEvent(this.query);
  @override
  List<Object?> get props => [query];
}
