import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/explore/data/datasources/explore_tmdb_datasource.dart';
import 'package:pelis_info/features/explore/data/repositories/explore_repository_impl.dart';

final exploreRepositoryProvider = Provider<ExploreRepositoryImpl>((ref) {
  return ExploreRepositoryImpl(ExploreTmdbDatasource());
});
