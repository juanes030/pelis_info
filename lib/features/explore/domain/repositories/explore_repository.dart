import 'package:pelis_info/features/explore/domain/entities/movie_genre.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

abstract class ExploreRepository {
  Future<List<MovieGenre>> getMovieGenres();
  Future<List<Movie>> discoverMoviesByGenre({required int genreId, int page = 1});
}
