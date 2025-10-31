import 'package:dio/dio.dart';
import 'package:pelis_info/config/constants/environment.dart';
import 'package:pelis_info/domain/datasources/movies_datasource.dart';
import 'package:pelis_info/domain/entities/movie.dart';
import 'package:pelis_info/infrastructure/mappers/movie_mapper.dart';
import 'package:pelis_info/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-CO'
    }
  ));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();
    return movies;
  }

}