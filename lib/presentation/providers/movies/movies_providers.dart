import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider = NotifierProvider<NowPlayingMoviesNotifier, List<Movie>>(NowPlayingMoviesNotifier.new);
final popularMoviesProvider = NotifierProvider<PopularMoviesNotifier, List<Movie>>(PopularMoviesNotifier.new);
final upcomingMoviesProvider = NotifierProvider<UpcomingMoviesNotifier, List<Movie>>(UpcomingMoviesNotifier.new);
final topRatedMoviesProvider = NotifierProvider<TopRatedMoviesNotifier, List<Movie>>(TopRatedMoviesNotifier.new);

abstract class MoviesNotifier extends Notifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;

  Future<List<Movie>> fetchPage(int page);

  @override
  List<Movie> build() => [];

  Future<void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchPage(currentPage);
    state = [...state, ...movies];
    await Future.delayed(Duration(milliseconds: 300));
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