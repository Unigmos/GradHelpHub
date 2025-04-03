import 'package:flutter/material.dart';

class MainTabViewModel extends ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;
}
