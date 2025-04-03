abstract class ApiRequest {
  String get endpoint;
  String get method;
  Map<String, dynamic>? get queryParameters;
  Map<String, dynamic>? get body;

  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
