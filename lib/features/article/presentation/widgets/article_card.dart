import 'package:flutter/material.dart';
import 'package:news_app/core/methods.dart';
import 'package:news_app/features/article/domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.grey.shade900,
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
  }
}
