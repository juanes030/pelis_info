import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/movie_detail/data/datasources/actor_moviedb_datasource.dart';
import 'package:pelis_info/features/movie_detail/data/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider<ActorsRepositoryImpl>((ref) {
  return ActorsRepositoryImpl(ActorMoviedbDatasource());
});
