import 'package:grad_help_hub/models/manager/search_manager.dart';
import 'package:grad_help_hub/models/model/share_article.dart';

class SearchService {
  final SearchManager _searchManager = SearchManager();

  static final SearchService _instance = SearchService._internal();

  factory SearchService() {
    return _instance;
  }

  SearchService._internal();

  Future<List<ShareArticle>> getSearchArticles(String keyword) async {
    final searchArticle = await _searchManager.searchArticles(keyword);
    return searchArticle;
  }
}
