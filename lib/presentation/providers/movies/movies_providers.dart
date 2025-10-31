import 'package:flutter_riverpod/legacy.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoremovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoremovies;

  MoviesNotifier({
    required this.fetchMoremovies
  }): super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoremovies(page: currentPage);
    state = [...state, ...movies];
  }
  
}