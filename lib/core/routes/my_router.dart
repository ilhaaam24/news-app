import 'package:go_router/go_router.dart';
import 'package:news_app/features/article/data/models/article_model.dart';
import 'package:news_app/features/article/presentation/pages/all_article_page.dart';
import 'package:news_app/features/article/presentation/pages/detail_article_page.dart';
import 'package:news_app/features/article/presentation/pages/home_page.dart';
import 'package:news_app/features/article/presentation/pages/trending_page.dart';
import 'package:news_app/features/auth/presentation/pages/sign_in_page.dart';

class MyRouter {
  get router => GoRouter(
    initialLocation: '/sign-in',
    routes: [
      GoRoute(
        path: '/sign-in',
        name: "sign_in",
        pageBuilder: (context, state) => NoTransitionPage(child: SignInPage()),
      ),
      GoRoute(
        path: '/',
        name: "home",
        pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
        routes: [
          GoRoute(
            path: 'trending-article', // HAPUS SLASH
            name: "trending_article",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: TrendingPage()),
          ),
        ],
      ),

      GoRoute(
        path: '/all-article',
        name: "all_article",
        pageBuilder: (context, state) =>
            NoTransitionPage(child: AllArticlePage()),
      ),

      GoRoute(
        path: '/detail-article',
        name: "detail_article",
        pageBuilder: (context, state) => NoTransitionPage(
          child: DetailArticlePage(state.extra as ArticleModel),
        ),
      ),
    ],
  );
}
