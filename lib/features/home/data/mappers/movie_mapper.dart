import 'package:pelis_info/features/home/data/models/moviedb/movie_details.dart';
import 'package:pelis_info/features/home/data/models/moviedb/movie_moviedb.dart';
import 'package:pelis_info/features/home/domain/entities/movie.dart';

class MovieMapper {
  // TMDb returns relative paths (e.g. "/xxx.jpg"); a fallback covers missing posters.
  static const _fallbackImage =
      'https://ih1.redbubble.net/image.5055723050.4010/flat,750x,075,f-pad,750x1000,f8f8f8.jpg';

  static String _fullImageUrl(String path) =>
      path.isNotEmpty ? 'https://image.tmdb.org/t/p/w500$path' : _fallbackImage;

  static Movie movieDBToEntity(MovieMovieDB movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath: _fullImageUrl(movieDb.backdropPath),
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: _fullImageUrl(movieDb.posterPath),
      releaseDate: movieDb.releaseDate ?? DateTime.now(),
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }

  static Movie movieDetailsToEntity(MovieDetails movieDetails) {
    return Movie(
      adult: movieDetails.adult,
      backdropPath: _fullImageUrl(movieDetails.backdropPath),
      genreIds: movieDetails.genres.map((genre) => genre.name).toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: _fullImageUrl(movieDetails.posterPath),
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount,
    );
  }
}
