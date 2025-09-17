import 'package:pelis_info_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}