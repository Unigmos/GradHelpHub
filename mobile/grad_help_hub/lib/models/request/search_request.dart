import 'package:grad_help_hub/models/request/api_request.dart';

class SearchRequest extends ApiRequest {
  @override
  final String endpoint;
  @override
  final String method;
  @override
  final Map<String, dynamic>? queryParameters;
  @override
  final Map<String, dynamic>? body;

  SearchRequest.searchArticles(String keyword)
      : endpoint = '/search',
        method = 'GET',
        queryParameters = {
          'keyword': keyword,
        },
        body = null;
}
