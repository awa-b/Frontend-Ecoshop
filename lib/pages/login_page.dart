import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();

  Future<void> _connexion() async {
    final serviceAuth = AuthService();
    final response = await serviceAuth.connexion(emailController.text, motDePasseController.text);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tokenAcces = data['jeton_acces'];

      Navigator.pushNamed(context, '/products', arguments: {
        'tokenAcces': tokenAcces,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de la connexion')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: motDePasseController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _connexion,
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Créer un compte"),
            ),
          ],
        ),
      ),
    );
  }
}