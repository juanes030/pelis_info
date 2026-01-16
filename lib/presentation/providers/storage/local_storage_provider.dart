import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/infrastructure/datasources/drift_datasource.dart';
import 'package:pelis_info/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: DriftDatasource());
});