class ErrorArticle {
  final int id;
  final String title;
  final String? language;
  final String? description;
  final String? cause;
  final String? solution;
  final DateTime insertedAt;
  final DateTime updatedAt;
  final bool? isErrors;

  ErrorArticle({
    required this.id,
    required this.title,
    this.language,
    this.description,
    this.cause,
    this.solution,
    required this.insertedAt,
    required this.updatedAt,
    this.isErrors = true,
  });

  factory ErrorArticle.fromJson(Map<String, dynamic> json) {
    return ErrorArticle(
      id: json['id'] as int,
      title: json['title'] as String,
      language: json['language'] as String?,
      description: json['description'] as String?,
      cause: json['cause'] as String?,
      solution: json['solution'] as String?,
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
      'cause': cause,
      'solution': solution,
      'inserted_at': insertedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
