import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grad_help_hub/views/main_tab_view/main_tab_view.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GradHelpHub',
      theme: ThemeData(
        // AppBarのテーマをグローバルに設定する方法
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3C383D),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFF8F2),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFFFF8F2),
          ),
        ),

        // ベースとなる色の設定
        primaryColor: const Color(0xFF3C383D),
        primaryColorDark: const Color(0xFF383437),
        primaryColorLight: const Color(0xFF3F3D42),
        scaffoldBackgroundColor: const Color(0xFF3C383D),

        // テキストテーマの設定
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFFF8F2)),
          bodyMedium: TextStyle(color: Color(0xFFFFF8F2)),
          titleLarge: TextStyle(color: Color(0xFFFFF8F2)),
          titleMedium: TextStyle(color: Color(0xFFFFF8F2)),
        ),

        // タブバーのテーマ設定
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFFFFF8F2),
          unselectedLabelColor: Color(0xFFC1B6C2),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFFF2755C), width: 2),
          ),
        ),

        // ボタンのテーマ設定
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF2755C),
            foregroundColor: const Color(0xFFFFF8F2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ),
      ),
      home: const MainTabView(),
    );
  }
}
