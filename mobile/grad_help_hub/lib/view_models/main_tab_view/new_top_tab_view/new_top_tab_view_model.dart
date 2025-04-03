import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/model/share_article.dart';
import 'package:grad_help_hub/models/service/error_service.dart';
import 'package:grad_help_hub/models/service/library_service.dart';

class NewTopTabViewModel extends ChangeNotifier {
  final ErrorService _errorService = ErrorService();
  final LibraryService _libraryService = LibraryService();
  List<ErrorArticle> _errorArticles = [];
  List<LibraryArticle> _libraryArticles = [];
  List<ShareArticle> _shareArticles = [];
  bool _mounted = true;
  bool _isLoading = false;

  List<ShareArticle> get shareArticles => _shareArticles;

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

  Future<void> loadRecentArticles() async {
    try {
      if (!_mounted) return;
      _errorArticles = await _errorService.getErrorArticle();
      _libraryArticles = await _libraryService.getLibraryArticle();

      _shareArticles = [
        ..._errorArticles.map((a) => ShareArticle.fromError(a)),
        ..._libraryArticles.map((b) => ShareArticle.fromLibrary(b)),
      ];

      _shareArticles.sort((a, b) => b.insertedAt.compareTo(a.insertedAt));
      _isLoading = false;
      _safeNotify();
    } catch (e) {
      if (!_mounted) return;
      _errorArticles = [];
      _libraryArticles = [];
      _shareArticles = [];
      _isLoading = true;
    } finally {
      _safeNotify();
    }
  }

  Future<void> refreshArticles() async {
    await loadRecentArticles();
  }
}
