import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tv/data/datasources/db/tv_show_database_helper.dart';
import 'package:tv/data/datasources/tv_show_local_data_source.dart';
import 'package:tv/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_show_repository.dart';

@GenerateMocks([
  TvShowDatabaseHelper,
  TvShowRepository,
  TvShowRemoteDataSource,
  TvShowLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
