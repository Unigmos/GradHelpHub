import 'package:flutter/material.dart';
import 'package:grad_help_hub/views/component/share_article_cell.dart';
import 'package:provider/provider.dart';
import 'package:grad_help_hub/view_models/main_tab_view/new_top_tab_view/new_top_tab_view_model.dart';

class NewTopTabView extends StatelessWidget {
  const NewTopTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewTopTabViewModel(),
      builder: (context, _) {
        final viewModel = context.watch<NewTopTabViewModel>();
        viewModel.loadRecentArticles();
        return Stack(
          children: [
            ListView.builder(
              itemCount: viewModel.shareArticles.length,
              itemBuilder: (context, index) {
                final shareArticle = viewModel.shareArticles[index];
                return ShareArticleCell(shareArticle: shareArticle);
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
