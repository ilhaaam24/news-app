import 'package:news_app/features/article/domain/entities/source.dart';

class SourceModel extends Source {
  const SourceModel({
    required super.id,
    required super.name,
    required super.url,
    required super.country,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
