import 'package:grad_help_hub/models/response/api_response.dart';

class ErrorResponse extends ApiResponse {
  ErrorResponse({
    required super.success,
    super.error,
    super.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      success: json['success'] as bool,
      error: json['error'] as String?,
      data: json['data'],
    );
  }

  factory ErrorResponse.success(dynamic data) {
    return ErrorResponse(success: true, data: data);
  }

  factory ErrorResponse.error(String error) {
    return ErrorResponse(success: false, error: error);
  }
}
