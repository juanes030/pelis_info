import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';
import 'package:pelis_info/features/home/data/providers/movie_repository_provider.dart';
import 'package:pelis_info/features/home/presentation/providers/home_movies_provider.dart';

final searchMoviesProvider = NotifierProvider<SearchedMoviesNotifier, List<Movie>>(SearchedMoviesNotifier.new);

class SearchedMoviesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() => const [];

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final movies = await ref.read(movieRepositoryProvider).searchMovies(query);
    ref.read(searchQueryProvider.notifier).setQuery(query);
    state = movies;
    return movies;
  }
}
