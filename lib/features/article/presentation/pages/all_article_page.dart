import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/methods.dart';
import 'package:news_app/features/article/presentation/bloc/article_bloc.dart';

class AllArticlePage extends StatelessWidget {
  const AllArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 0,
        selectedIconTheme: IconThemeData(color: Colors.black),
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, '/');
          } else if (value == 1) {
            Navigator.pushNamed(context, '/explore_page');
          } else if (value == 2) {
            Navigator.pushNamed(context, '/bookmark_page');
          } else if (value == 3) {
            Navigator.pushNamed(context, '/profile_page');
          }
        },
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.grey.shade800),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined, color: Colors.grey.shade800),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outline_outlined,
              color: Colors.grey.shade800,
            ),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: Colors.grey.shade800),
            label: 'Profile',
          ),
        ],
      ),
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
                    return Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(article.image),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),

                          Text(
                            article.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            spacing: 16,
                            children: [
                              Text(
                                article.source.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.grey,
                                    size: 14,
                                  ),

                                  Text(
                                    getRelativeTIme(article.publishedAt),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
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
