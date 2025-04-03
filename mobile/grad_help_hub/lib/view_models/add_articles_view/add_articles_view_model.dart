import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/service/error_service.dart';
import 'package:grad_help_hub/models/service/library_service.dart';

class AddArticlesViewModel extends ChangeNotifier {
  final ErrorService _errorService = ErrorService();
  final LibraryService _libraryService = LibraryService();
  List<ErrorArticle> _errorArticles = [];
  List<LibraryArticle> _libraryArticles = [];
  bool _mounted = true;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void _safeNotify() {
    if (_mounted) {
      notifyListeners();
    }
  }

  Future<void> postArticles(Map<String, dynamic> articleData) async {
    try {
      if (!_mounted) return;
      if (articleData['category'] == '問題解決') {
        _errorArticles = (await _errorService.createErrorArticle(
            article: articleData)) as List<ErrorArticle>;
      } else {
        _libraryArticles = (await _libraryService.createLibraryArticle(
            article: articleData)) as List<LibraryArticle>;
      }

      _safeNotify();
    } catch (e) {
      if (!_mounted) return;
      _errorArticles = [];
      _libraryArticles = [];
    } finally {
      _safeNotify();
    }
  }
}
