import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';

class SearchArticle {
  final List<ErrorArticle> errors;
  final List<LibraryArticle> libraries;

  SearchArticle({
    required this.errors,
    required this.libraries,
  });

  factory SearchArticle.fromJson(Map<String, dynamic> json) {
    return SearchArticle(
      errors: json['errors'] as List<ErrorArticle>,
      libraries: json['usable_libraries'] as List<LibraryArticle>,
    );
  }
}
