import 'package:pelis_info/features/explore/domain/datasources/explore_datasource.dart';
import 'package:pelis_info/features/explore/domain/entities/movie_genre.dart';
import 'package:pelis_info/features/explore/domain/repositories/explore_repository.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  const ExploreRepositoryImpl(this.datasource);

  final ExploreDatasource datasource;

  @override
  Future<List<MovieGenre>> getMovieGenres() {
    return datasource.getMovieGenres();
  }

  @override
  Future<List<Movie>> discoverMoviesByGenre({
    required int genreId,
    int page = 1,
  }) {
    return datasource.discoverMoviesByGenre(genreId: genreId, page: page);
  }
}
