import 'package:flutter/material.dart';
import 'package:grad_help_hub/view_models/articles_datail_view/articles_datail_view_model.dart';
import 'package:provider/provider.dart';

class ArticlesDatailView extends StatelessWidget {
  final ArticlesDatailViewModel viewModel;
  const ArticlesDatailView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
            title: Text('${viewModel.displayTitle}'),
            titleTextStyle: const TextStyle(
              color: Color(0xFFFFF8F2),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            )),
        body: Consumer<ArticlesDatailViewModel>(
          builder: (context, viewModel, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {},
                    child: Text(
                      viewModel.displayLanguage,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  (viewModel.displayCause.isEmpty)
                      ? Text(
                          '使用可否 :',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : const SizedBox(height: 0),
                  (viewModel.displayCause.isEmpty)
                      ? Text(
                          (viewModel.displayUsableFlag) ? "○" : "×",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : const SizedBox(height: 0),
                  const SizedBox(height: 10),
                  Text(
                    '説明 :',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    viewModel.displayDescription,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  (viewModel.displayCause.isNotEmpty)
                      ? Text(
                          '原因 :',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : const SizedBox(height: 0),
                  (viewModel.displayCause.isNotEmpty)
                      ? const SizedBox(height: 5)
                      : const SizedBox(height: 0),
                  (viewModel.displayCause.isNotEmpty)
                      ? Text(
                          viewModel.displayCause,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : const SizedBox(height: 0),
                  (viewModel.displaySolution.isNotEmpty)
                      ? const SizedBox(height: 10)
                      : const SizedBox(height: 0),
                  (viewModel.displaySolution.isNotEmpty)
                      ? Text(
                          '解決策 :',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : const SizedBox(height: 0),
                  (viewModel.displaySolution.isNotEmpty)
                      ? const SizedBox(height: 5)
                      : const SizedBox(height: 0),
                  (viewModel.displaySolution.isNotEmpty)
                      ? Text(
                          viewModel.displaySolution,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : const SizedBox(height: 0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
