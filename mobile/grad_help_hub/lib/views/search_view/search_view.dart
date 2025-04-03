import 'package:flutter/material.dart';
import 'package:grad_help_hub/view_models/search_view/search_view_model.dart';
import 'package:grad_help_hub/views/component/share_article_cell.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchView> {
  final TextEditingController _searchBarTextController =
      new TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Consumer<SearchViewModel>(
                builder: (context, viewModel, child) {
                  return Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3C383D),
                      ),
                      controller: _searchBarTextController,
                      decoration: InputDecoration(
                        hintText: '検索',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: viewModel.searchKeyword.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  viewModel.clearSearch();
                                  _searchBarTextController.clear();
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        viewModel.onSearchWordChanged(value);
                      },
                    ),
                  );
                },
              ),
            ),
            Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (viewModel.shareArticles.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            viewModel.searchKeyword.isEmpty
                                ? '検索キーワードを入力してください'
                                : '検索結果が見つかりませんでした',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final result = viewModel.shareArticles[index];
                      return ShareArticleCell(shareArticle: result);
                    },
                    childCount: viewModel.shareArticles.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
