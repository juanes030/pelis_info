import 'package:pelis_info/domain/datasources/actors_datasource.dart';
import 'package:pelis_info/domain/entities/actor.dart';
import 'package:pelis_info/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}