import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:news_app/features/news/data/datasources/remote_datasource.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<ArticleRemoteDataSourceImpl>(),
  MockSpec<http.Client>(),
])


void main() {
  var cat = MockCat();
}
