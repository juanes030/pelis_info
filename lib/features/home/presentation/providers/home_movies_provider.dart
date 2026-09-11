import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';
import 'package:pelis_info/features/home/data/providers/movie_repository_provider.dart';

final nowPlayingMoviesProvider = NotifierProvider<NowPlayingMoviesNotifier, List<Movie>>(NowPlayingMoviesNotifier.new);
final popularMoviesProvider = NotifierProvider<PopularMoviesNotifier, List<Movie>>(PopularMoviesNotifier.new);
final upcomingMoviesProvider = NotifierProvider<UpcomingMoviesNotifier, List<Movie>>(UpcomingMoviesNotifier.new);
final topRatedMoviesProvider = NotifierProvider<TopRatedMoviesNotifier, List<Movie>>(TopRatedMoviesNotifier.new);

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  return step1 || step2 || step3 || step4;
});

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) return const [];
  return nowPlayingMovies.sublist(0, 6);
});

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

abstract class MoviesNotifier extends Notifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;

  Future<List<Movie>> fetchPage(int page);

  @override
  List<Movie> build() => const [];

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final movies = await fetchPage(currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

class NowPlayingMoviesNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchPage(int page) => ref.read(movieRepositoryProvider).getNowPlaying(page: page);
}

class PopularMoviesNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchPage(int page) => ref.read(movieRepositoryProvider).getPopular(page: page);
}

class UpcomingMoviesNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchPage(int page) => ref.read(movieRepositoryProvider).getUpcoming(page: page);
}

class TopRatedMoviesNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchPage(int page) => ref.read(movieRepositoryProvider).getTopRated(page: page);
}
