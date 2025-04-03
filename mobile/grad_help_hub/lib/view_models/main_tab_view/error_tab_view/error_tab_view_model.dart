import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/service/error_service.dart';

class ErrorTabViewModel extends ChangeNotifier {
  final ErrorService _errorService = ErrorService();
  List<ErrorArticle> _errorArticles = [];
  bool _isLoading = false;
  bool _mounted = true;

  List<ErrorArticle> get errorArticles => _errorArticles;
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
      _errorArticles = await _errorService.getErrorArticle();
      _errorArticles.sort((a, b) => b.insertedAt.compareTo(a.insertedAt));
      _isLoading = false;
      _safeNotify();
    } catch (e) {
      _isLoading = true;
      _errorArticles = [];
    } finally {
      _safeNotify();
    }
  }

  Future<void> refreshArticles() async {
    await loadArticles();
  }
}
