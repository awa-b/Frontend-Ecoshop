import 'package:flutter/material.dart';
import 'package:ecoshop_flutter/theme.dart'; // Le fichier theme.dart
import 'package:ecoshop_flutter/pages/login_page.dart';
import 'package:ecoshop_flutter/pages/register_page.dart';
import 'package:ecoshop_flutter/pages/profile_page.dart';
import 'package:ecoshop_flutter/pages/success_page.dart';
import 'package:ecoshop_flutter/pages/history_page.dart';
import 'package:ecoshop_flutter/pages/product_list_page.dart';
import 'package:ecoshop_flutter/pages/product_detail_page.dart';
import 'package:ecoshop_flutter/models/product.dart';
import 'package:ecoshop_flutter/pages/search_history_page.dart';

void main() {
  runApp(const MonApp());
}

class MonApp extends StatelessWidget {
  const MonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoShop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // <-- Utilisation du thème global
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/success': (context) => const SuccessPage(),
        '/history': (context) => const HistoryPage(),
        '/products': (context) => const ProductListPage(),
        '/search-history': (context) => const SearchHistoryPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/profile') {
          final args = settings.arguments as Map<String, dynamic>;
          final tokenAcces = args['tokenAcces'] as String;
          return MaterialPageRoute(
            builder: (context) => ProfilePage(tokenAcces: tokenAcces),
          );
        } else if (settings.name == '/product-detail') {
          final args = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: args),
          );
        }
        return null;
      },
    );
  }
}