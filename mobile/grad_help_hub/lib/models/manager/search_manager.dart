import 'package:grad_help_hub/models/manager/api_manager.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/model/search_article.dart';
import 'package:grad_help_hub/models/model/share_article.dart';
import 'package:grad_help_hub/models/request/search_request.dart';
import 'package:grad_help_hub/models/response/search_response.dart';

class SearchManager {
  final APIManager _apiManager = APIManager();
  SearchArticle? serchArticle;
  List<ShareArticle> shareArticles = [];

  Future<List<ShareArticle>> searchArticles(String keyword) async {
    final request = SearchRequest.searchArticles(keyword);
    final response = await _apiManager.sendRequest(request);
    final searchResponse = SearchResponse.fromJson(response);
    final List errors = searchResponse.errors as List;
    final List libraries = searchResponse.libraries as List;

    if (searchResponse.success) {
      if (errors.isEmpty && libraries.isEmpty) {
        return shareArticles;
      } else if (errors.isEmpty) {
        shareArticles = [
          ...libraries
              .map((json) => LibraryArticle.fromJson(json))
              .toList()
              .map((b) => ShareArticle.fromLibrary(b)),
        ];
      } else if (libraries.isEmpty) {
        shareArticles = [
          ...errors
              .map((json) => ErrorArticle.fromJson(json))
              .toList()
              .map((a) => ShareArticle.fromError(a)),
        ];
      } else {
        shareArticles = [
          ...errors
              .map((json) => ErrorArticle.fromJson(json))
              .toList()
              .map((a) => ShareArticle.fromError(a)),
          ...libraries
              .map((json) => LibraryArticle.fromJson(json))
              .toList()
              .map((b) => ShareArticle.fromLibrary(b)),
        ];
      }
      return shareArticles;
    } else {
      throw Exception(searchResponse.error);
    }
  }
}
