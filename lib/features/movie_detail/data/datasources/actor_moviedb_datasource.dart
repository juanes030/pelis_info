import 'package:dio/dio.dart';
import 'package:pelis_info/core/constants/environment.dart';
import 'package:pelis_info/features/movie_detail/data/mappers/actor_mapper.dart';
import 'package:pelis_info/features/movie_detail/data/models/credits_response.dart';
import 'package:pelis_info/features/movie_detail/domain/datasources/actors_datasource.dart';
import 'package:pelis_info/features/movie_detail/domain/entities/actor.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-CO'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    return actors;
  }

}