import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/models/model/library_article.dart';
import 'package:grad_help_hub/models/model/share_article.dart';

class ArticlesDatailViewModel extends ChangeNotifier {
  String _displayTitle = '';
  String _displayLanguage = '';
  String _displayDescription = '';
  String _displayCause = '';
  String _displaySolution = '';
  bool _displayUsableFlag = false;
  DateTime _displayInsertedAt = DateTime.now();

  String get displayTitle => _displayTitle;
  String get displayLanguage => _displayLanguage;
  String get displayDescription => _displayDescription;
  String get displayCause => _displayCause;
  String get displaySolution => _displaySolution;
  bool get displayUsableFlag => _displayUsableFlag;
  DateTime get displayInsertedAt => _displayInsertedAt;

  void setItemData(ShareArticle article) {
    _displayTitle = article.title;
    _displayLanguage = article.language ?? "";
    _displayDescription = article.description ?? "";
    _displayInsertedAt = article.insertedAt;
    if (article.isErrors ?? false) {
      _displayCause = article.cause ?? "";
      _displaySolution = article.solution ?? "";
      notifyListeners();
    } else {
      _displayUsableFlag = article.usableFlag ?? false;
      notifyListeners();
    }
  }

  void setErrorsData(ErrorArticle article) {
    _displayTitle = article.title;
    _displayLanguage = article.language ?? "";
    _displayDescription = article.description ?? "";
    _displayInsertedAt = article.insertedAt;
    _displayCause = article.cause ?? "";
    _displaySolution = article.solution ?? "";
    notifyListeners();
  }

  void setLibraryData(LibraryArticle article) {
    _displayTitle = article.title;
    _displayLanguage = article.language ?? "";
    _displayDescription = article.description ?? "";
    _displayInsertedAt = article.insertedAt;
    _displayUsableFlag = article.usableFlag ?? false;
    notifyListeners();
  }
}
