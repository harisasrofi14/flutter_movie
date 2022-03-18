import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

@GenerateMocks([MovieRepository, TvShowRepository],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
