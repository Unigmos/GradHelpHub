class LibraryArticle {
  final int id;
  final String title;
  final String? language;
  final String? description;
  final bool? usableFlag;
  final DateTime insertedAt;
  final DateTime updatedAt;
  final bool? isErrors;

  LibraryArticle({
    required this.id,
    required this.title,
    this.language,
    this.description,
    this.usableFlag,
    required this.insertedAt,
    required this.updatedAt,
    this.isErrors = false,
  });

  factory LibraryArticle.fromJson(Map<String, dynamic> json) {
    return LibraryArticle(
      id: json['id'] as int,
      title: json['title'] as String,
      language: json['language'] as String?,
      description: json['description'] as String?,
      usableFlag: json['usable_flag'] as bool?,
      insertedAt: DateTime.parse(json['inserted_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'language': language,
      'description': description,
      'usable_flag': usableFlag,
      'inserted_at': insertedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
