import 'package:flutter/material.dart';
import 'package:grad_help_hub/views/add_articles_view/add_articles_view.dart';
import 'package:grad_help_hub/views/main_tab_view/error_tab_view/error_tab_view.dart';
import 'package:grad_help_hub/views/main_tab_view/library_tab_view/library_tab_view.dart';
import 'package:grad_help_hub/views/main_tab_view/new_top_tab_view/new_top_tab_view.dart';
import 'package:grad_help_hub/views/search_view/search_view.dart';

class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GradHelpHub'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchView(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: '新着TOP'),
              Tab(text: '問題解決'),
              Tab(text: 'ライブラリ'),
            ],
            onTap: (value) {
              print(value);
            },
          ),
        ),
        body: const TabBarView(
          children: [
            NewTopTabView(),
            ErrorTabView(),
            LibraryTabView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFFFF8F2),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddArticlesView(),
              ),
            );
          },
          child: const Icon(Icons.add, color: Color(0xFF544549)),
        ),
      ),
    );
  }
}
