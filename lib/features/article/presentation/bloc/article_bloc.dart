import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/article/domain/entities/article.dart';
import 'package:news_app/features/article/domain/usecases/get_article_by_category.dart';
import 'package:news_app/features/article/domain/usecases/get_article_by_query.dart';

import 'package:news_app/features/article/domain/usecases/get_articles.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleByCategory getAllArticleByCategory;
  final GetArticles getArticles;
  final GetArticleByQuery getArticleByQuery;
  ArticleBloc(
    this.getArticles,
    this.getAllArticleByCategory,
    this.getArticleByQuery,
  ) : super(ArticleEmpty()) {
    on<ArticleEvent>((event, emit) async {
      if (event is GetAllArticle) {
        emit(ArticleLoading());

        Either<Failur, List<Article>> result = await getArticles.execute(
          event.page,
        );

        result.fold(
          (leftResul) {
            emit(ArticleError("Cannot get articles"));
          },
          (rightresult) {
            emit(AllArticleLoaded(rightresult));
          },
        );
      }
      if (event is GetAllArticleByCategoryEvent) {
        emit(ArticleLoading());

        Either<Failur, List<Article>> result = await getAllArticleByCategory
            .execute(event.category);

        result.fold(
          (leftResul) {
            emit(ArticleError("Cannot get articles"));
          },
          (rightresult) {
            emit(AllArticleByCategoryLoaded(rightresult));
          },
        );
      }
      if (event is GetArticleByQueryEvent) {
        emit(ArticleLoading());

        Either<Failur, List<Article>> result = await getArticleByQuery.execute(
          event.query,
        );

        result.fold((leftResult){
          emit(ArticleError("Cannot get articles"));
        }, (rightResult){
          emit(ArticleByQueryLoaded(rightResult));
        });
      }
    });
  }
}
