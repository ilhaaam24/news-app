import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/article/presentation/bloc/article_bloc.dart';
import 'package:news_app/features/article/presentation/widgets/article_card.dart';
import 'package:news_app/features/article/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:news_app/injection.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Trending',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ArticleBloc, ArticleState>(
          bloc: myInjection<ArticleBloc>()..add(GetAllArticle(1)),
          builder: (context, state) {
            if (state is ArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ArticleError) {
              return Center(child: Text(state.message));
            }

            if (state is AllArticleLoaded) {
              final article = state.articles;
              return ListView.builder(
                itemCount: article.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: article[index]);
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
