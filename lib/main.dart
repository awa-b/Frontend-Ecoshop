import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/profile_page.dart';
import 'pages/update_profile_page.dart';
import 'pages/searches_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecoshop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/accueil',
      routes: {
        '/login': (context) => const LoginPage(),
        '/accueil':(context)  => const ProductsPage(),
        '/modif_profil':(context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          final tokenAcces = args?['tokenAcces'] ?? '';
          return UpdateProfilePage(tokenAcces: tokenAcces);
        },
        '/register': (context) => const RegisterPage(),
        '/profile': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          final tokenAcces = args?['tokenAcces'] ?? '';
          return ProfilePage(tokenAcces: tokenAcces);
        },
      },
    );
  }
}