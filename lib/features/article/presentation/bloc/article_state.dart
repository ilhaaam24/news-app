part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {}

final class ArticleInitial extends ArticleState {
  @override
  List<Object?> get props => [];
}

final class ArticleEmpty extends ArticleState {
  @override
  List<Object?> get props => [];
}

final class ArticleLoading extends ArticleState {
  @override
  List<Object?> get props => [];
}

final class ArticleError extends ArticleState {
  final String message;
  ArticleError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AllArticleLoaded extends ArticleState {
  final List<Article> articles;
  AllArticleLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

final class ArticleLoaded extends ArticleState {
  final Article articles;
  ArticleLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}
