import 'package:drift/drift.dart' as drift;
import 'package:pelis_info/config/database/database.dart';
import 'package:pelis_info/domain/datasources/local_storage_datasource.dart';
import 'package:pelis_info/domain/entities/movie.dart';

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse]): database = databaseToUse ?? db;

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final query = database.select(database.favoriteMovies)..where((table) => table.movieId.equals(movieId));
    final favoriteMovie = await query.getSingleOrNull();
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) async {
    final query = database.select(database.favoriteMovies)..limit(limit, offset: offset);
    final favoriteMovieRows = await query.get();
    final movies = favoriteMovieRows.map((row) => Movie(
      adult: false, 
      backdropPath: row.backdropPath, 
      genreIds: const [], 
      id: row.movieId, 
      originalLanguage: '', 
      originalTitle: row.originalTitle, 
      overview: '', 
      popularity: 0, 
      posterPath: row.posterPath, 
      releaseDate: DateTime.now(), 
      title: row.title, 
      video: false, 
      voteAverage: row.voteAverage, 
      voteCount: 0
    )).toList();
    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);
    if(isFavorite){
      final deleteQuery = database.delete(database.favoriteMovies)..where((table) => table.movieId.equals(movie.id));
      await deleteQuery.go();
      return;
    }
    await database.into(database.favoriteMovies).insert(FavoriteMoviesCompanion.insert(
      movieId: movie.id, 
      backdropPath: movie.backdropPath, 
      originalTitle: movie.originalTitle, 
      posterPath: movie.posterPath, 
      title: movie.title,
      voteAverage: drift.Value(movie.voteAverage)
    ));
  }

}