import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:pelis_info/infrastructure/repositories/actors_repository_impl.dart';


final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorMoviedbDatasource());
});