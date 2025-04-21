import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController(); // Ajouté
  final TextEditingController motDePasseController = TextEditingController();
  final TextEditingController confirmerMotDePasseController = TextEditingController();

  Future<void> _inscription() async {
    if (motDePasseController.text != confirmerMotDePasseController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    final serviceAuth = AuthService();
    final response = await serviceAuth.inscription(
      emailController.text,
      usernameController.text,
      motDePasseController.text,
      confirmerMotDePasseController.text,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription réussie, veuillez vous connecter')),
      );
      Navigator.pushNamed(context, '/login');
    } else {
      String message = 'Échec de l\'inscription';
      try {
        final data = jsonDecode(response.body);
        if (data is Map && data.isNotEmpty) {
          message = data.values.first[0];
        }
      } catch (e) {
        print('Erreur parsing JSON: $e');
      }

      print('Erreur lors de l\'inscription');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
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
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: motDePasseController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmerMotDePasseController,
              decoration: InputDecoration(labelText: 'Confirmer mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _inscription,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
