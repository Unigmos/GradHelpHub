import 'package:grad_help_hub/models/manager/error_manager.dart';
import 'package:grad_help_hub/models/model/error_article.dart';

class ErrorService {
  final ErrorManager _errorManager = ErrorManager();

  final Map<int, ErrorArticle> _errorArticleCache = {};

  static final ErrorService _instance = ErrorService._internal();

  factory ErrorService() {
    return _instance;
  }

  ErrorService._internal();

  Future<ErrorArticle> getErrorArticleWithCache(int articleId) async {
    if (_errorArticleCache.containsKey(articleId)) {
      return _errorArticleCache[articleId]!;
    }

    final errorArticle = await _errorManager.getErrorArticle(articleId);
    _errorArticleCache[articleId] = errorArticle;
    return errorArticle;
  }

  // 記事検索
  Future<List<ErrorArticle>> getErrorArticle() async {
    final errorArticles = await _errorManager.getErrors();
    return errorArticles;
  }

  Future<ErrorArticle> createErrorArticle(
      {required Map<String, dynamic> article}) async {
    String title = article['タイトル(必須)'] ?? "タイトルなし";
    String? language = article['言語'];
    String? description = article['説明'];
    String? cause = article['原因'];
    String? solution = article['解決方法'];
    final errorArticle = await _errorManager.createErrorArticle(
      title: title,
      language: language,
      description: description,
      cause: cause,
      solution: solution,
    );
    _errorArticleCache[errorArticle.id] = errorArticle;
    return errorArticle;
  }

  // 記事の更新
  Future<ErrorArticle> updateErrorArticle({
    required int articleId,
    String? title,
    String? language,
    String? description,
    String? cause,
    String? solution,
  }) async {
    final errorArticle = await _errorManager.updateErrorArticle(
      articleId,
      title: title,
      language: language,
      description: description,
      cause: cause,
      solution: solution,
    );
    _errorArticleCache[errorArticle.id] = errorArticle;
    return errorArticle;
  }

  Future<void> deleteErrorArticleById(int articleId) async {
    await _errorManager.deleteErrorArticle(articleId);
    _errorArticleCache.remove(articleId);
  }

  void clearCache() {
    _errorArticleCache.clear();
  }
}
