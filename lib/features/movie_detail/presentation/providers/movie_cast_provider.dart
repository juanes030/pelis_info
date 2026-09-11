import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelis_info/features/movie_detail/domain/entities/actor.dart';
import 'package:pelis_info/features/movie_detail/data/providers/actors_repository_provider.dart';

final actorsByMovieProvider = NotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(ActorsByMovieNotifier.new);

class ActorsByMovieNotifier extends Notifier<Map<String, List<Actor>>> {
  @override
  Map<String, List<Actor>> build() => {};

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await ref.read(actorsRepositoryProvider).getActorsByMovie(movieId);
    state = {...state, movieId: actors};
  }
}
