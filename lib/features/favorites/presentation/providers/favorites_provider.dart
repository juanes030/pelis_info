import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/favorites/data/providers/local_storage_provider.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

final favoriteMoviesProvider = NotifierProvider<StorageMoviesNotifier, Map<int, Movie>>(StorageMoviesNotifier.new);

class StorageMoviesNotifier extends Notifier<Map<int, Movie>> {
  int page = 0;

  @override
  Map<int, Movie> build() => {};

  Future<List<Movie>> loadNextPage() async {
    final localStorageRepository = ref.read(localStorageRepositoryProvider);
    final movies = await localStorageRepository.loadFavoriteMovies(
      limit: 10,
      offset: page * 10,
    );

    page++;

    final tempMovies = <int, Movie>{};
    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};
    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    final localStorageRepository = ref.read(localStorageRepositoryProvider);
    final isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);
    await localStorageRepository.toggleFavoriteMovie(movie);

    if (isFavorite) {
      state = Map<int, Movie>.from(state)..remove(movie.id);
      return;
    }

    state = {...state, movie.id: movie};
  }
}
