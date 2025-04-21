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
      final tokenAcces = data['jeton_acces']; // Attention au nom exact dans ta réponse JSON

      Navigator.pushNamed(context, '/profile', arguments: {
        'tokenAcces': tokenAcces,
      });
    } else {
      print('Erreur de connexion');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la connexion')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: motDePasseController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _connexion,
              child: Text('Se connecter'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Créer un compte"),
            ),
          ],
        ),
      ),
    );
  }
}