import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/share_article.dart';
import 'package:grad_help_hub/models/service/search_service.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  List<ShareArticle> _shareArticles = [];
  bool _mounted = true;
  bool _isLoading = false;
  String _searchKeyword = "";
  String? _error;
  Timer? _debounceTimer;

  List<ShareArticle> get shareArticles => _shareArticles;

  String get searchKeyword => _searchKeyword;
  bool get isLoading => _isLoading;
  String? get error => _error;

  @override
  void dispose() {
    _mounted = false;
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _safeNotify() {
    if (_mounted) {
      notifyListeners();
    }
  }

  Future<void> onSearchWordChanged(String keyword) async {
    _searchKeyword = keyword;
    _safeNotify();

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), _search);
  }

  Future<void> _search() async {
    if (!_mounted) return;
    if (_searchKeyword.isEmpty) {
      _shareArticles = [];
      _safeNotify();
      return;
    }

    _isLoading = true;
    _error = null;
    _safeNotify();

    try {
      final results = await _searchService.getSearchArticles(_searchKeyword);
      results.sort((a, b) => a.insertedAt.compareTo(b.insertedAt));

      if (!_mounted) return;

      _shareArticles = results;
    } catch (e) {
      if (!_mounted) return;

      _error = '検索中にエラーが発生しました';
      _shareArticles = [];
    } finally {
      if (!_mounted) return;
      _isLoading = false;
      _safeNotify();
    }
  }

  void clearSearch() {
    _searchKeyword = '';
    _shareArticles = [];
    _error = null;
    _safeNotify();
  }
}
