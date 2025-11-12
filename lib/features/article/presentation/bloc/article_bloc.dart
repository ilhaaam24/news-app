import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/failur.dart';
import 'package:news_app/features/article/domain/entities/article.dart';
import 'package:news_app/features/article/domain/usecases/get_articles.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  ArticleBloc(this.getArticles) : super(ArticleEmpty()) {
    on<ArticleEvent>((event, emit) async {
      if (event is GetAllArticle) {
        emit(ArticleLoading());

        Either<Failur, List<Article>> result = await getArticles.execute(
          event.page,
        );

        print(result);

        result.fold(
          (leftResul) {
            emit(ArticleError("Cannot get articles"));
          },
          (rightresult) {
            emit(AllArticleLoaded(rightresult));
          },
        );
      }
    });
  }
}
