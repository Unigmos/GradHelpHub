import 'package:flutter/material.dart';
import 'package:grad_help_hub/models/model/share_article.dart';
import 'package:grad_help_hub/view_models/articles_datail_view/articles_datail_view_model.dart';
import 'package:grad_help_hub/views/articles_datail_view/articles_datail_view.dart';

class ShareArticleCell extends StatelessWidget {
  final ShareArticle shareArticle;

  const ShareArticleCell({
    super.key,
    required this.shareArticle,
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
      color: (shareArticle.isErrors ?? false)
          ? Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          shareArticle.title,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (shareArticle.usableFlag != null) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (shareArticle.usableFlag != null)
                    Text(
                      '使用可否：${shareArticle.usableFlag! == true ? "○" : "×"}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ],
            if (shareArticle.description != null) ...[
              const SizedBox(height: 8),
              Text(
                shareArticle.description!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        onTap: () {
          final viewModel = ArticlesDatailViewModel()
            ..setItemData(shareArticle);
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
