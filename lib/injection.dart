import "package:http/http.dart" as http;
import "package:get_it/get_it.dart";
import "package:news_app/features/article/data/datasources/remote_datasource.dart";
import "package:news_app/features/article/data/repositories/article_repository_impl.dart";
import "package:news_app/features/article/domain/repositories/article_repository.dart";
import "package:news_app/features/article/domain/usecases/get_article_by_category.dart";
import "package:news_app/features/article/domain/usecases/get_articles.dart";
import "package:news_app/features/article/presentation/bloc/article_bloc.dart";

var myInjection = GetIt.instance;

Future<void> init() async {
  // Global dependency
  myInjection.registerLazySingleton(() => http.Client());

  // Feature article
  // Bloc
  myInjection.registerFactory(() => ArticleBloc(myInjection(), myInjection()));
  // Repository
  myInjection.registerFactory<ArticleRepository>(
    () => ArticleRepositoryImpl(articleRemoteDataSource: myInjection()),
  );
  // usecase
  myInjection.registerLazySingleton(() => GetArticles(myInjection()));
  myInjection.registerLazySingleton(() => GetArticleByCategory(myInjection()));

  // datasource
  myInjection.registerLazySingleton<ArticleRemoteDatasource>(
    () => ArticleRemoteDataSourceImpl(myInjection()),
  );
}
