import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/favorites/data/providers/local_storage_provider.dart';

final isFavoriteMovieProvider = FutureProvider.family<bool, int>((ref, movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isFavoriteMovie(movieId);
});
