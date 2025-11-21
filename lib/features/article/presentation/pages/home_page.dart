// --- IMPORT TETAP SAMA
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/methods.dart';
import 'package:news_app/features/article/presentation/bloc/article_bloc.dart';
import 'package:news_app/features/article/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:news_app/features/article/presentation/widgets/latest_article_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // global animations (interval-based)
  late Animation<double> fadeHeader;
  late Animation<double> fadeTitle;
  late Animation<Offset> slideTitle;
  late Animation<double> fadeSearch;
  late Animation<double> scaleSearch;
  late Animation<Offset> slideTrending;
  late Animation<double> fadeImage;
  late Animation<double> scaleImage;
  late Animation<double> fadeCategories;

  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  String selectedCategory = "all";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeHeader = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
    );

    slideTitle = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.40, curve: Curves.easeOut),
      ),
    );

    fadeTitle = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.40, curve: Curves.easeIn),
    );

    fadeSearch = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.55),
    );

    scaleSearch = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.55, curve: Curves.easeOutBack),
      ),
    );

    // TRENDING SECTION
    slideTrending = Tween<Offset>(begin: Offset(-0.3, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.65, curve: Curves.easeOut),
          ),
        );

    // TRENDING IMAGE
    fadeImage = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.75),
    );

    scaleImage = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.75, curve: Curves.easeOut),
      ),
    );

    // CATEGORIES
    fadeCategories = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 0.9),
    );

    searchController.addListener(_onSearchChanged);
    context.read<ArticleBloc>().add(GetAllArticleByCategoryEvent('general'));

    _controller.forward();
  }

  // debounce
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final text = searchController.text.trim();

      if (text.isEmpty) {
        context.read<ArticleBloc>().add(
          GetAllArticleByCategoryEvent(selectedCategory),
        );
      } else {
        context.read<ArticleBloc>().add(GetArticleByQueryEvent(text));
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List categories = [
      'all',
      'world',
      'nation',
      'business',
      'technology',
      'entertainment',
      'sports',
      'science',
      'health',
    ];

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// -------------------------------------
                /// HEADER ANIMATION
                /// -------------------------------------
                FadeTransition(
                  opacity: fadeHeader,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.newspaper_outlined, size: 28),
                      Stack(
                        children: [
                          const Icon(
                            Icons.notifications_none_rounded,
                            size: 28,
                          ),
                          Positioned(
                            right: 0,
                            top: 2,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: fadeTitle,
                  child: SlideTransition(
                    position: slideTitle,
                    child: Text(
                      "Discover the latest news",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  "Stay updated with trending stories around you.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 16),
                FadeTransition(
                  opacity: fadeSearch,
                  child: ScaleTransition(
                    scale: scaleSearch,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search articles...',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                    final isSearching = searchController.text.trim().isNotEmpty;
                    if (isSearching && state is ArticleByQueryLoaded) {
                      final articles = state.articles;

                      if (articles.isEmpty)
                        return const Text("No results found.");

                      return Column(
                        children: List.generate(
                          articles.length,
                          (i) => AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(milliseconds: 300 + (i * 100)),
                            child: LatestArticleCard(articles: articles[i]),
                          ),
                        ),
                      );
                    }

                    if (!isSearching && state is AllArticleByCategoryLoaded) {
                      final articles = state.articles;
                      final trending = articles.last;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideTransition(
                            position: slideTrending,
                            child: Row(
                              children: [
                                Text(
                                  "Trending",
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      context.goNamed("trending_article"),
                                  child: Text(
                                    "See all",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// --- TRENDING IMAGE ---
                          FadeTransition(
                            opacity: fadeImage,
                            child: ScaleTransition(
                              scale: scaleImage,
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(trending.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// --- TRENDING TEXT & SOURCE ---
                          FadeTransition(
                            opacity: fadeImage,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trending.title,
                                  style: theme.textTheme.titleMedium,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      trending.source.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.access_time_outlined, size: 14),
                                    SizedBox(width: 4),
                                    Text(getRelativeTIme(trending.publishedAt)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// --- LATEST TITLE ---
                          FadeTransition(
                            opacity: fadeCategories,
                            child: Row(
                              children: [
                                Text(
                                  "Latest",
                                  style: theme.textTheme.titleLarge,
                                ),
                                Spacer(),
                                Text(
                                  "See all",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// --- CATEGORIES ---
                          FadeTransition(
                            opacity: fadeCategories,
                            child: SizedBox(
                              height: 24,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(
                                        () => selectedCategory =
                                            categories[index],
                                      );
                                      context.read<ArticleBloc>().add(
                                        GetAllArticleByCategoryEvent(
                                          categories[index],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                categories[index] ==
                                                    selectedCategory
                                                ? Colors.blueAccent
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// --- ARTICLE LIST WITH STAGGERED ANIMATION ---
                          Column(
                            children: List.generate(
                              articles.length,
                              (i) => AnimatedSlide(
                                duration: Duration(
                                  milliseconds: 400 + (i * 80),
                                ),
                                offset: Offset(0, -0.1),
                                curve: Curves.easeOut,
                                child: AnimatedOpacity(
                                  opacity: 1,
                                  duration: Duration(
                                    milliseconds: 400 + (i * 80),
                                  ),
                                  child: LatestArticleCard(
                                    articles: articles[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
