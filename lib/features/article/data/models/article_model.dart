import 'package:news_app/features/article/data/models/source_model.dart';
import 'package:news_app/features/article/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.url,
    required super.image,
    required super.publishedAt,
    required super.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      source: SourceModel.fromJson(json['source'] ?? {}),
    );
  }
}
