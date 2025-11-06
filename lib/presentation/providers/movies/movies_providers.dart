import 'package:flutter_riverpod/legacy.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoremovies: fetchMoreMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoremovies: fetchMoreMovies
  );
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(
    fetchMoremovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoremovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoremovies;

  MoviesNotifier({
    required this.fetchMoremovies
  }): super([]);

  Future<void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoremovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(Duration(milliseconds: 300));
    isLoading = false;
  }
  
}