import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';

class ShareArticle {
  final int id;
  final String title;
  final String? language;
  final String? description;
  final String? cause;
  final String? solution;
  final bool? usableFlag;
  final DateTime insertedAt;
  final DateTime updatedAt;
  final bool? isErrors;

  ShareArticle({
    required this.id,
    required this.title,
    this.language,
    this.description,
    this.cause,
    this.solution,
    this.usableFlag,
    required this.insertedAt,
    required this.updatedAt,
    this.isErrors = true,
  });

  factory ShareArticle.fromError(ErrorArticle errorArticle) {
    return ShareArticle(
      id: errorArticle.id,
      title: errorArticle.title,
      language: errorArticle.language,
      description: errorArticle.description,
      cause: errorArticle.cause,
      solution: errorArticle.solution,
      insertedAt: errorArticle.insertedAt,
      updatedAt: errorArticle.updatedAt,
      isErrors: errorArticle.isErrors,
    );
  }

  factory ShareArticle.fromLibrary(LibraryArticle libraryArticle) {
    return ShareArticle(
      id: libraryArticle.id,
      title: libraryArticle.title,
      language: libraryArticle.language,
      description: libraryArticle.description,
      usableFlag: libraryArticle.usableFlag,
      insertedAt: libraryArticle.insertedAt,
      updatedAt: libraryArticle.updatedAt,
      isErrors: libraryArticle.isErrors,
    );
  }
}
