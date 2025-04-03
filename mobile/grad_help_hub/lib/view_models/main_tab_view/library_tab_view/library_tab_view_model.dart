import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/service/library_service.dart';

class LibraryTabViewModel extends ChangeNotifier {
  final LibraryService _libraryService = LibraryService();
  List<LibraryArticle> _libraryArticles = [];
  bool _mounted = true;
  bool _isLoading = false;

  List<LibraryArticle> get libraryArticles => _libraryArticles;
  bool get isLoading => _isLoading;

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

  Future<void> loadArticles() async {
    try {
      _libraryArticles = await _libraryService.getLibraryArticle();
      _libraryArticles.sort((a, b) => b.insertedAt.compareTo(a.insertedAt));
      _isLoading = false;
      _safeNotify();
    } catch (e) {
      _isLoading = true;
      _libraryArticles = [];
    } finally {
      _safeNotify();
    }
  }

  Future<void> refreshArticles() async {
    await loadArticles();
  }
}
