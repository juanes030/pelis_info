import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/favorites/data/datasources/drift_datasource.dart';
import 'package:pelis_info/features/favorites/data/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider<LocalStorageRepositoryImpl>((ref) {
  return LocalStorageRepositoryImpl(datasource: DriftDatasource());
});
