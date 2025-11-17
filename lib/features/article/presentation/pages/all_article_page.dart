import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/article/presentation/bloc/article_bloc.dart';
import 'package:news_app/features/article/presentation/widgets/article_card.dart';
import 'package:news_app/features/article/presentation/widgets/custom_bottom_navigation_bar.dart';

class AllArticlePage extends StatelessWidget {
  const AllArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        animateColor: true,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'All News',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          child: BlocBuilder<ArticleBloc, ArticleState>(
            bloc: context.read<ArticleBloc>()..add(GetAllArticle(1)),
            builder: (context, state) {
              if (state is ArticleLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ArticleError) {
                return Center(child: Text(state.message));
              }
              if (state is AllArticleLoaded) {
                final articles = state.articles;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleCard(article: article);
                  },
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
