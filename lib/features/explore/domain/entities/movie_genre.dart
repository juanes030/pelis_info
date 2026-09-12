class MovieGenre {
  const MovieGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory MovieGenre.fromJson(Map<String, dynamic> json) {
    return MovieGenre(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
