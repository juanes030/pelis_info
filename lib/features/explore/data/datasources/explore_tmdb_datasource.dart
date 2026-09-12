import 'package:dio/dio.dart';
import 'package:pelis_info/core/constants/environment.dart';
import 'package:pelis_info/features/explore/domain/datasources/explore_datasource.dart';
import 'package:pelis_info/features/explore/domain/entities/movie_genre.dart';
import 'package:pelis_info/features/home/data/mappers/movie_mapper.dart';
import 'package:pelis_info/features/home/data/models/moviedb/moviedb_response.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

class ExploreTmdbDatasource implements ExploreDatasource {
  ExploreTmdbDatasource()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3',
            queryParameters: {
              'api_key': Environment.theMovieDbKey,
              'language': 'es-CO',
            },
          ),
        );

  final Dio dio;

  @override
  Future<List<MovieGenre>> getMovieGenres() async {
    final response = await dio.get('/genre/movie/list');
    final genres = response.data['genres'] as List<dynamic>;
    return genres
        .map((genre) => MovieGenre.fromJson(genre as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Movie>> discoverMoviesByGenre({
    required int genreId,
    int page = 1,
  }) async {
    final response = await dio.get(
      '/discover/movie',
      queryParameters: {
        'with_genres': genreId,
        'page': page,
        'include_adult': false,
        'sort_by': 'popularity.desc',
      },
    );

    final movieResponse = MovieDbResponse.fromJson(response.data);
    return movieResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map(MovieMapper.movieDBToEntity)
        .toList();
  }
}
