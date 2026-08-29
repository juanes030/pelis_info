import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = NotifierProvider<SearchedMoviesNotifier, List<Movie>>(SearchedMoviesNotifier.new);

class SearchedMoviesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() => [];

  Future<List<Movie>> searchMoviesByQuery(String query) async{
    final List<Movie> movies = await ref.read(movieRepositoryProvider).searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    
    return movies;
  }
}