import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/error_article.dart';
import 'package:grad_help_hub/view_models/articles_datail_view/articles_datail_view_model.dart';
import 'package:grad_help_hub/views/articles_datail_view/articles_datail_view.dart';

class ErrorArticleCell extends StatelessWidget {
  final ErrorArticle errorArticle;

  const ErrorArticleCell({
    super.key,
    required this.errorArticle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
        ),
      ),
      color: Theme.of(context).primaryColorLight,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          errorArticle.title,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorArticle.description != null) ...[
              const SizedBox(height: 8),
              Text(
                errorArticle.description!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        onTap: () {
          final viewModel = ArticlesDatailViewModel()
            ..setErrorsData(errorArticle);
          // 記事をタップした時の処理
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlesDatailView(viewModel: viewModel),
            ),
          );
        },
      ),
    );
  }
}
