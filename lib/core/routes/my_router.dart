import 'package:go_router/go_router.dart';
import 'package:news_app/features/article/presentation/pages/all_article_page.dart';
import 'package:news_app/features/article/presentation/pages/detail_article_page.dart';

class MyRouter {
  get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: "all_article",
        pageBuilder: (context, state) =>
            NoTransitionPage(child: AllArticlePage()),
        routes: [
          GoRoute(
            path: 'detail-article',
            name: "detail_article",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: DetailArticlePage(state.extra as int)),
          ),
        ],
      ),
    ],
  );
}
