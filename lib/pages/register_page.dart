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
  final TextEditingController motDePasseController = TextEditingController();
  final TextEditingController confirmerMotDePasseController = TextEditingController();

  Future<void> _inscription() async {
    if (motDePasseController.text != confirmerMotDePasseController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    final serviceAuth = AuthService();
    final response = await serviceAuth.inscription(emailController.text, motDePasseController.text);

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie, veuillez vous connecter')),
      );
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de l\'inscription')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
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
            const SizedBox(height: 16),
            TextField(
              controller: confirmerMotDePasseController,
              decoration: const InputDecoration(labelText: 'Confirmer mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _inscription,
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}