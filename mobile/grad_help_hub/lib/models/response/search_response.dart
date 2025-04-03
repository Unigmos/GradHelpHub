import 'package:grad_help_hub/models/response/api_response.dart';

class SearchResponse extends ApiResponse {
  SearchResponse({
    required super.success,
    super.error,
    super.errors,
    super.libraries,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      success: json['success'] as bool,
      error: json['error'] as String?,
      errors: json['errors'],
      libraries: json['usable_libraries'],
    );
  }

  factory SearchResponse.success(dynamic errors, dynamic libraries) {
    return SearchResponse(success: true, errors: errors, libraries: libraries);
  }

  factory SearchResponse.error(String error) {
    return SearchResponse(success: false, error: error);
  }
}
