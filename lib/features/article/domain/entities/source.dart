import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String id;
  final String name;
  final String url;
  final String country;

  const Source({
    required this.id,
    required this.name,
    required this.url,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, url, country];
}
