import 'package:flutter/material.dart';
import 'package:news_application/screens/article.dart';
import 'package:news_application/screens/articles_bycategory.dart';
import 'package:news_application/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/articles/byCategory':
        return MaterialPageRoute(
          builder: (_) => ArticlesByCategory(
            id: args,
          ),
        );
      case '/article':
        return MaterialPageRoute(
          builder: (_) => ArticleScreen(
            id: args,
          ),
        );
    }
  }
}
