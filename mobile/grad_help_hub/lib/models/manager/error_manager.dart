import 'package:grad_help_hub/models/manager/api_manager.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/request/error_request.dart';
import 'package:grad_help_hub/models/response/error_response.dart';

class ErrorManager {
  final APIManager _apiManager = APIManager();

  Future<List<ErrorArticle>> getErrors() async {
    final request = ErrorRequest.getErrors();
    final response = await _apiManager.sendRequest(request);
    final errorResponse = ErrorResponse.fromJson(response);

    if (errorResponse.success) {
      final List data = errorResponse.data as List;
      return data.map((json) => ErrorArticle.fromJson(json)).toList();
    } else {
      throw Exception(errorResponse.error);
    }
  }

  Future<ErrorArticle> getErrorArticle(int articleId) async {
    final request = ErrorRequest.getErrorArticle(articleId);
    final response = await _apiManager.sendRequest(request);
    final errorResponse = ErrorResponse.fromJson(response);

    if (errorResponse.success) {
      return ErrorArticle.fromJson(errorResponse.data);
    } else {
      throw Exception(errorResponse.error);
    }
  }

  Future<ErrorArticle> createErrorArticle({
    required String title,
    String? language,
    String? description,
    String? cause,
    String? solution,
  }) async {
    final request = ErrorRequest.createErrorArticle(
        title: title,
        language: language,
        description: description,
        cause: cause,
        solution: solution);

    final response = await _apiManager.sendRequest(request);
    final errorResponse = ErrorResponse.fromJson(response);

    if (errorResponse.success) {
      return ErrorArticle.fromJson(errorResponse.data);
    } else {
      throw Exception(errorResponse.error);
    }
  }

  Future<ErrorArticle> updateErrorArticle(
    int articleId, {
    required title,
    String? language,
    String? description,
    String? cause,
    String? solution,
  }) async {
    final request = ErrorRequest.updateErrorArticle(
      articleId,
      title: title,
      language: language,
      description: description,
      cause: cause,
      solution: solution,
    );
    final response = await _apiManager.sendRequest(request);
    final errorResponse = ErrorResponse.fromJson(response);

    if (errorResponse.success) {
      return ErrorArticle.fromJson(errorResponse.data);
    } else {
      throw Exception(errorResponse.error);
    }
  }

  Future<void> deleteErrorArticle(int articleId) async {
    final request = ErrorRequest.deleteArticle(articleId);
    final response = await _apiManager.sendRequest(request);
    final errorResponse = ErrorResponse.fromJson(response);

    if (!errorResponse.success) {
      throw Exception(errorResponse.error);
    }
  }
}
