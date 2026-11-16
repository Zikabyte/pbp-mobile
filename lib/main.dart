import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/app_theme.dart';
import 'package:portfolio_mobile/features/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
