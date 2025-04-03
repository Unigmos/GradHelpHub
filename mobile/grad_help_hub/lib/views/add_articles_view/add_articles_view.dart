import 'package:flutter/material.dart';
import 'package:grad_help_hub/view_models/add_articles_view/add_articles_view_model.dart';
import 'package:provider/provider.dart';

class AddArticlesView extends StatefulWidget {
  const AddArticlesView({super.key});

  @override
  _AddArticlesViewState createState() => _AddArticlesViewState();
}

class _AddArticlesViewState extends State<AddArticlesView> {
  final Map<String, List<dynamic>> _categoryFields = {
    '問題解決': ['タイトル(必須)', '言語', '説明', '原因', '解決方法'],
    'ライブラリ': [
      'タイトル(必須)',
      '言語',
      {
        'type': 'toggle',
        'label': '使用可否',
        'activeColor': const Color(0xFFF2755C),
        'inactiveColor': const Color(0xFFC1B6C2)
      },
      '説明'
    ],
  };

  String _selectedCategory = '問題解決';
  late List<dynamic> _controllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controllers =
        List.generate(_categoryFields[_selectedCategory]!.length, (index) {
      var field = _categoryFields[_selectedCategory]![index];

      // トグルの場合は初期値をfalseに
      if (field is Map && field['type'] == 'toggle') {
        return ValueNotifier<bool>(false);
      }

      // テキストフィールドの場合はTextEditingControllerを作成
      return TextEditingController();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      if (controller is TextEditingController) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Color(0xFFFFF8F2)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color(0xFFC1B6C2)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFC1B6C2)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFF2755C), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(Map<String, dynamic> toggleInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: _controllers[
            _categoryFields[_selectedCategory]!.indexOf(toggleInfo)],
        builder: (context, isToggled, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                toggleInfo['label'],
                style:
                    const TextStyle(color: Color.fromARGB(171, 255, 248, 242)),
              ),
              Switch.adaptive(
                value: isToggled,
                onChanged: (bool value) {
                  (_controllers[_categoryFields[_selectedCategory]!
                          .indexOf(toggleInfo)] as ValueNotifier<bool>)
                      .value = value;
                },
                activeColor: toggleInfo['activeColor'],
                inactiveThumbColor: toggleInfo['inactiveColor'],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddArticlesViewModel(),
      builder: (context, _) {
        final viewModel = context.watch<AddArticlesViewModel>();
        return Scaffold(
          backgroundColor: const Color(0xFF3C383D),
          appBar: AppBar(
            backgroundColor: const Color(0xFF3C383D),
            leading: IconButton(
              icon: const Icon(Icons.close, color: Color(0xFFFFF8F2)),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _saveArticle(viewModel);
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: const Text(
                  '保存',
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  dropdownColor: const Color(0xFF3C383D),
                  decoration: InputDecoration(
                    labelText: 'カテゴリ',
                    labelStyle: const TextStyle(color: Color(0xFFC1B6C2)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFC1B6C2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFFF2755C), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: const TextStyle(color: Color(0xFFFFF8F2)),
                  items: _categoryFields.keys.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newCategory) {
                    if (newCategory != null) {
                      setState(() {
                        _selectedCategory = newCategory;
                        _initControllers();
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _categoryFields[_selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    var field = _categoryFields[_selectedCategory]![index];

                    if (field is String) {
                      return _buildTextField(
                          field, _controllers[index] as TextEditingController);
                    } else if (field is Map<String, dynamic> &&
                        field['type'] == 'toggle') {
                      return _buildToggleButton(field);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveArticle(AddArticlesViewModel viewModel) {
    Map<String, dynamic> articleData = {'category': _selectedCategory};

    for (int index = 0;
        index < _categoryFields[_selectedCategory]!.length;
        index++) {
      var field = _categoryFields[_selectedCategory]![index];

      if (field is String) {
        // テキストフィールドの値
        articleData[field] =
            (_controllers[index] as TextEditingController).text;
      } else if (field is Map && field['type'] == 'toggle') {
        // トグルの値
        articleData[field['label']] =
            (_controllers[index] as ValueNotifier<bool>).value;
      }
    }
    articleData.entries.map((entry) {});
    if (articleData['タイトル(必須)'].isEmpty) {
      showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(
                'タイトルを入力してください',
                style: TextStyle(
                  color: Color(0xFF3C383D),
                  fontSize: 18,
                ),
              ),
              actions: <Widget>[
                SimpleDialogOption(
                  child: const Text('OK',
                      style: TextStyle(
                        color: Color(0xFF3C383D),
                        fontSize: 18,
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              backgroundColor: const Color(0xFFFFF8F2),
            );
          });
    } else {
      viewModel.postArticles(articleData);
      Navigator.pop(context);
    }
  }
}
