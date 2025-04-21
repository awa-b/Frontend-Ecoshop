import 'package:flutter/material.dart';
import 'package:ecoshop_flutter/services/auth_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nouveauMotDePasseController = TextEditingController();

  Future<void> _reinitialiserMotDePasse() async {
    final authService = AuthService();
    final response = await authService.reinitialiserMotDePasse(
      emailController.text,
      nouveauMotDePasseController.text,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mot de passe réinitialisé avec succès')),
      );
      Navigator.pop(context); // Retour à la page précédente
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la réinitialisation')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réinitialiser le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Adresse Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nouveauMotDePasseController,
              decoration: InputDecoration(labelText: 'Nouveau mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _reinitialiserMotDePasse,
              child: Text('Réinitialiser'),
            ),
          ],
        ),
      ),
    );
  }
}