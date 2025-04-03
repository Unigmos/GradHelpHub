import 'package:grad_help_hub/models/manager/api_manager.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/request/library_request.dart';
import 'package:grad_help_hub/models/response/library_response.dart';

class LibraryManager {
  final APIManager _apiManager = APIManager();

  Future<List<LibraryArticle>> getLibrarys() async {
    final request = LibraryRequest.getLibrarys();
    final response = await _apiManager.sendRequest(request);
    final libraryResponse = LibraryResponse.fromJson(response);

    if (libraryResponse.success) {
      final List data = libraryResponse.data as List;
      return data.map((json) => LibraryArticle.fromJson(json)).toList();
    } else {
      throw Exception(libraryResponse.error);
    }
  }

  Future<LibraryArticle> getLibraryArticle(int articleId) async {
    final request = LibraryRequest.getLibraryArticle(articleId);
    final response = await _apiManager.sendRequest(request);
    final libraryResponse = LibraryResponse.fromJson(response);

    if (libraryResponse.success) {
      return LibraryArticle.fromJson(libraryResponse.data);
    } else {
      throw Exception(libraryResponse.error);
    }
  }

  Future<LibraryArticle> createLibraryArticle({
    required String title,
    String? language,
    String? description,
    bool? usableFlag,
  }) async {
    final request = LibraryRequest.createLibraryArticle(
        title: title,
        language: language,
        description: description,
        usableFlag: usableFlag);
    final response = await _apiManager.sendRequest(request);
    final libraryResponse = LibraryResponse.fromJson(response);

    if (libraryResponse.success) {
      return LibraryArticle.fromJson(libraryResponse.data);
    } else {
      throw Exception(libraryResponse.error);
    }
  }

  Future<LibraryArticle> updateLibraryArticle(
    int articleId, {
    required title,
    String? language,
    String? description,
    bool? usableFlag,
  }) async {
    final request = LibraryRequest.updateLibraryArticle(articleId,
        title: title,
        language: language,
        description: description,
        usableFlag: usableFlag);
    final response = await _apiManager.sendRequest(request);
    final libraryResponse = LibraryResponse.fromJson(response);

    if (libraryResponse.success) {
      return LibraryArticle.fromJson(libraryResponse.data);
    } else {
      throw Exception(libraryResponse.error);
    }
  }

  Future<void> deleteLibraryArticle(int articleId) async {
    final request = LibraryRequest.deleteArticle(articleId);
    final response = await _apiManager.sendRequest(request);
    final libraryResponse = LibraryResponse.fromJson(response);

    if (!libraryResponse.success) {
      throw Exception(libraryResponse.error);
    }
  }
}
