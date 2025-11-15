import 'package:flutter_riverpod/legacy.dart';
import 'package:pelis_info/domain/entities/actor.dart';
import 'package:pelis_info/presentation/providers/providers.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorRepository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>>{
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}): super({});

  Future<void> loadActors(String movieId) async {
    if(state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}