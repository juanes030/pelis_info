import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';
import 'package:pelis_info/features/home/data/providers/movie_repository_provider.dart';

final movieInfoProvider = NotifierProvider<MovieMapNotifier, Map<String, Movie>>(MovieMapNotifier.new);

class MovieMapNotifier extends Notifier<Map<String, Movie>> {
  @override
  Map<String, Movie> build() => {};

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await ref.read(movieRepositoryProvider).getMovieById(movieId);
    state = {...state, movieId: movie};
  }
}
