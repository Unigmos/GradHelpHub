import 'package:flutter/material.dart';
import 'package:grad_help_hub/view_models/main_tab_view/error_tab_view/error_tab_view_model.dart';
import 'package:grad_help_hub/views/component/error_article_cell.dart';
import 'package:provider/provider.dart';

class ErrorTabView extends StatelessWidget {
  const ErrorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ErrorTabViewModel(),
      builder: (context, _) {
        final viewModel = context.watch<ErrorTabViewModel>();
        viewModel.loadArticles();
        return Stack(
          children: [
            ListView.builder(
              itemCount: viewModel.errorArticles.length,
              itemBuilder: (context, index) {
                final errorArticle = viewModel.errorArticles[index];
                return ErrorArticleCell(errorArticle: errorArticle);
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
