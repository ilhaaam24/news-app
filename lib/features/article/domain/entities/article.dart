import 'package:equatable/equatable.dart';
import 'package:news_app/features/article/domain/entities/source.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final String publishedAt;
  final Source source;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.source,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    content,
    url,
    image,
    publishedAt,
    source,
  ];
}
