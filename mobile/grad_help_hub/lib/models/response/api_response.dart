abstract class ApiResponse {
  final bool success;
  final String? error;
  final dynamic data;
  final dynamic errors;
  final dynamic libraries;

  ApiResponse({
    required this.success,
    this.error,
    this.data,
    this.errors,
    this.libraries,
  });
}
