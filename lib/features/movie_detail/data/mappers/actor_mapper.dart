import 'package:pelis_info/features/movie_detail/data/models/credits_response.dart';
import 'package:pelis_info/features/movie_detail/domain/entities/actor.dart';

class ActorMapper {
  static const _fallbackProfileImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

  static Actor castToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: (cast.profilePath != null && cast.profilePath!.isNotEmpty)
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : _fallbackProfileImage,
      character: cast.character,
    );
  }
}
