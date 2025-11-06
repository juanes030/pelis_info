import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/presentation/providers/providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref){
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if(nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0,6);
});