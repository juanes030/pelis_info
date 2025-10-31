import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/infrastructure/datasources/moviedb_datasource.dart';
import 'package:pelis_info/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});