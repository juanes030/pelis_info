import 'package:pelis_info/features/home/data/models/moviedb/movie_moviedb.dart';

class MovieDbResponse {
  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final int page;
  final List<MovieMovieDB> results;
  final int totalPages;
  final int totalResults;

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
    dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
    page: json['page'] ?? 0,
    results: List<MovieMovieDB>.from((json['results'] ?? []).map((x) => MovieMovieDB.fromJson(x))),
    totalPages: json['total_pages'] ?? 0,
    totalResults: json['total_results'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'dates': dates?.toJson(),
    'page': page,
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
    'total_pages': totalPages,
    'total_results': totalResults,
  };
}

class Dates {
  Dates({required this.maximum, required this.minimum});

  final DateTime maximum;
  final DateTime minimum;

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.tryParse(json['maximum']?.toString() ?? '') ?? DateTime.now(),
    minimum: DateTime.tryParse(json['minimum']?.toString() ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    'maximum': '${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}',
    'minimum': '${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}',
  };
}
