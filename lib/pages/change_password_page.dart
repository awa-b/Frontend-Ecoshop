import 'package:flutter/material.dart';
import 'package:ecoshop_flutter/services/auth_service.dart';

class ChangePasswordPage extends StatefulWidget {
  final String tokenAcces;

  const ChangePasswordPage({Key? key, required this.tokenAcces}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController ancienMotDePasseController = TextEditingController();
  final TextEditingController nouveauMotDePasseController = TextEditingController();

  Future<void> _changerMotDePasse() async {
    final authService = AuthService();
    final response = await authService.changerMotDePasse(
      widget.tokenAcces,
      ancienMotDePasseController.text,
      nouveauMotDePasseController.text,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mot de passe changé avec succès')),
      );
      Navigator.pop(context); // Retourner à la page précédente
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec du changement de mot de passe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changer le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ancienMotDePasseController,
              decoration: InputDecoration(labelText: 'Ancien mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: nouveauMotDePasseController,
              decoration: InputDecoration(labelText: 'Nouveau mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _changerMotDePasse,
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}