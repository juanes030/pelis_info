import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/home/data/datasources/moviedb_datasource.dart';
import 'package:pelis_info/features/home/data/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider<MovieRepositoryImpl>((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
