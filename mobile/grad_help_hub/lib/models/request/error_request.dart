import 'package:grad_help_hub/models/request/api_request.dart';

class ErrorRequest extends ApiRequest {
  @override
  final String endpoint;
  @override
  final String method;
  @override
  final Map<String, dynamic>? queryParameters;
  @override
  final Map<String, dynamic>? body;

  ErrorRequest.getErrors()
      : endpoint = '/errors',
        method = 'GET',
        queryParameters = null,
        body = null;

  ErrorRequest.getErrorArticle(int articleId)
      : endpoint = '/errors/$articleId',
        method = 'GET',
        queryParameters = null,
        body = null;

  ErrorRequest.createErrorArticle({
    required String title,
    String? language,
    String? description,
    String? cause,
    String? solution,
  })  : endpoint = '/errors',
        method = 'POST',
        queryParameters = null,
        body = {
          'title': title,
          if (language != null) 'language': language,
          if (description != null) 'description': description,
          if (cause != null) 'cause': cause,
          if (solution != null) 'solution': solution,
        };

  ErrorRequest.updateErrorArticle(
    int articleId, {
    required String title,
    String? language,
    String? description,
    String? cause,
    String? solution,
  })  : endpoint = '/errors/$articleId',
        method = 'PUT',
        queryParameters = null,
        body = {
          'title': title,
          if (language != null) 'language': language,
          if (description != null) 'description': description,
          if (cause != null) 'cause': cause,
          if (solution != null) 'solution': solution,
        };

  ErrorRequest.deleteArticle(int articleId)
      : endpoint = '/errors/$articleId',
        method = 'DELETE',
        queryParameters = null,
        body = null;
}
