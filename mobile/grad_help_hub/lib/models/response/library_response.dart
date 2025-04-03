import 'package:grad_help_hub/models/response/api_response.dart';

class LibraryResponse extends ApiResponse {
  LibraryResponse({
    required super.success,
    super.error,
    super.data,
  });

  factory LibraryResponse.fromJson(Map<String, dynamic> json) {
    return LibraryResponse(
      success: json['success'] as bool,
      error: json['error'] as String?,
      data: json['data'],
    );
  }

  factory LibraryResponse.success(dynamic data) {
    return LibraryResponse(success: true, data: data);
  }

  factory LibraryResponse.error(String error) {
    return LibraryResponse(success: false, error: error);
  }
}
