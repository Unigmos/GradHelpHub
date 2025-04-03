import 'package:flutter/material.dart';
import 'package:grad_help_hub/view_models/main_tab_view/library_tab_view/library_tab_view_model.dart';
import 'package:grad_help_hub/views/component/library_article_cell.dart';
import 'package:provider/provider.dart';

class LibraryTabView extends StatelessWidget {
  const LibraryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryTabViewModel(),
      builder: (context, _) {
        final viewModel = context.watch<LibraryTabViewModel>();
        viewModel.loadArticles();
        return Stack(
          children: [
            ListView.builder(
              itemCount: viewModel.libraryArticles.length,
              itemBuilder: (context, index) {
                final libraryArticle = viewModel.libraryArticles[index];
                return LibraryArticleCell(libraryArticle: libraryArticle);
              },
            ),
            if (viewModel.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
