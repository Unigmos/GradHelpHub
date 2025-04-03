import 'package:grad_help_hub/models/manager/library_manager.dart';
import 'package:grad_help_hub/models/model/library_article.dart';

class LibraryService {
  final LibraryManager _libraryManager = LibraryManager();

  final Map<int, LibraryArticle> _libraryArticleCache = {};

  static final LibraryService _instance = LibraryService._internal();

  factory LibraryService() {
    return _instance;
  }

  LibraryService._internal();

  Future<LibraryArticle> getLibraryArticleWithCache(int articleId) async {
    if (_libraryArticleCache.containsKey(articleId)) {
      return _libraryArticleCache[articleId]!;
    }

    final libraryArticle = await _libraryManager.getLibraryArticle(articleId);
    _libraryArticleCache[articleId] = libraryArticle;
    return libraryArticle;
  }

  // 記事検索
  Future<List<LibraryArticle>> getLibraryArticle() async {
    final libraryArticles = await _libraryManager.getLibrarys();
    return libraryArticles;
  }

  Future<LibraryArticle> createLibraryArticle(
      {required Map<String, dynamic> article}) async {
    String title = article['タイトル(必須)'] ?? "タイトルなし";
    String? language = article['言語'];
    String? description = article['説明'];
    bool? usableFlag = article['使用可否'] as bool?;
    final libraryArticle = await _libraryManager.createLibraryArticle(
      title: title,
      language: language,
      description: description,
      usableFlag: usableFlag,
    );
    _libraryArticleCache[libraryArticle.id] = libraryArticle;
    return libraryArticle;
  }

  // 記事の更新
  Future<LibraryArticle> updateLibraryArticle({
    required int articleId,
    String? title,
    String? language,
    String? description,
    bool? usableFlag,
  }) async {
    final libraryArticle = await _libraryManager.updateLibraryArticle(
      articleId,
      title: title,
      language: language,
      description: description,
      usableFlag: usableFlag,
    );
    _libraryArticleCache[libraryArticle.id] = libraryArticle;
    return libraryArticle;
  }

  Future<void> deleteLibraryArticleById(int articleId) async {
    await _libraryManager.deleteLibraryArticle(articleId);
    _libraryArticleCache.remove(articleId);
  }

  void clearCache() {
    _libraryArticleCache.clear();
  }
}
