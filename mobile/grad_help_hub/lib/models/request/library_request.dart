import 'package:grad_help_hub/models/request/api_request.dart';

class LibraryRequest extends ApiRequest {
  @override
  final String endpoint;
  @override
  final String method;
  @override
  final Map<String, dynamic>? queryParameters;
  @override
  final Map<String, dynamic>? body;

  LibraryRequest.getLibrarys()
      : endpoint = '/usable_libraries',
        method = 'GET',
        queryParameters = null,
        body = null;

  LibraryRequest.getLibraryArticle(int articleId)
      : endpoint = '/usable_libraries/$articleId',
        method = 'GET',
        queryParameters = null,
        body = null;

  LibraryRequest.createLibraryArticle({
    required String title,
    final String? language,
    final String? description,
    final bool? usableFlag,
  })  : endpoint = '/usable_libraries',
        method = 'POST',
        queryParameters = null,
        body = {
          'title': title,
          if (language != null) 'language': language,
          if (description != null) 'description': description,
          if (usableFlag != null) 'usableFlag': usableFlag,
        };

  LibraryRequest.updateLibraryArticle(
    int articleId, {
    required String title,
    final String? language,
    final String? description,
    final bool? usableFlag,
  })  : endpoint = '/usable_libraries/$articleId',
        method = 'PUT',
        queryParameters = null,
        body = {
          'title': title,
          if (language != null) 'language': language,
          if (description != null) 'description': description,
          if (usableFlag != null) 'usableFlag': usableFlag,
        };

  LibraryRequest.deleteArticle(int articleId)
      : endpoint = '/usable_libraries/$articleId',
        method = 'DELETE',
        queryParameters = null,
        body = null;
}
