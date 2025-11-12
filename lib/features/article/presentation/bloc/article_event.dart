part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {}

class GetAllArticle extends ArticleEvent {
  final int page;
  GetAllArticle(this.page);

  @override
  List<Object?> get props => [page];
}

class GetDetailarticle extends ArticleEvent {
  final int id;
  GetDetailarticle(this.id);

  @override
  List<Object?> get props => [id];
}
