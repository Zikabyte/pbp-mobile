import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/app_theme.dart';
import 'package:portfolio_mobile/features/home/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zikafolio',
      theme: AppTheme.light,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
