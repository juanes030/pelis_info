import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/explore/data/providers/explore_repository_provider.dart';
import 'package:pelis_info/features/explore/domain/entities/movie_genre.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

final exploreGenresProvider =
    NotifierProvider<ExploreGenresNotifier, List<MovieGenre>>(
  ExploreGenresNotifier.new,
);

final exploreMoviesProvider =
    NotifierProvider<ExploreMoviesNotifier, List<Movie>>(
  ExploreMoviesNotifier.new,
);

class ExploreGenresNotifier extends Notifier<List<MovieGenre>> {
  String? errorMessage;

  @override
  List<MovieGenre> build() => const [];

  Future<void> loadGenres() async {
    if (state.isNotEmpty) return;
    try {
      errorMessage = null;
      state = await ref.read(exploreRepositoryProvider).getMovieGenres();
    } catch (_) {
      errorMessage = 'No pudimos cargar los géneros.';
      state = [...state];
    }
  }
}

class ExploreMoviesNotifier extends Notifier<List<Movie>> {
  int? selectedGenreId;
  int currentPage = 0;
  bool isLoading = false;
  bool isLastPage = false;
  String? errorMessage;

  @override
  List<Movie> build() => const [];

  void clearSelection() {
    selectedGenreId = null;
    currentPage = 0;
    isLastPage = false;
    isLoading = false;
    errorMessage = null;
    state = const [];
  }

  Future<void> selectGenre(int genreId) async {
    if (selectedGenreId == genreId && state.isNotEmpty) return;

    selectedGenreId = genreId;
    currentPage = 0;
    isLastPage = false;
    errorMessage = null;
    state = const [];
    await loadNextPage();
  }

  Future<List<Movie>> loadNextPage() async {
    final genreId = selectedGenreId;
    if (genreId == null || isLoading || isLastPage) return const [];

    isLoading = true;
    try {
      errorMessage = null;
      final nextPage = currentPage + 1;
      final movies = await ref
          .read(exploreRepositoryProvider)
          .discoverMoviesByGenre(genreId: genreId, page: nextPage);

      currentPage = nextPage;
      state = [...state, ...movies];
      if (movies.isEmpty) isLastPage = true;
      return movies;
    } catch (_) {
      errorMessage = 'No pudimos cargar las películas.';
      state = [...state];
      return const [];
    } finally {
      isLoading = false;
    }
  }
}
