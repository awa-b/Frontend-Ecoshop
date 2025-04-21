import 'package:flutter/material.dart';

class ModifProfilPage extends StatefulWidget {
  const ModifProfilPage({Key? key}) : super(key: key);

  @override
  State<ModifProfilPage> createState() => _ModifProfilPageState();
}

class _ModifProfilPageState extends State<ModifProfilPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController biographieController = TextEditingController();

  Future<void> _mettreAJourProfil() async {
    // À connecter avec votre API de modification de profil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour (fonction fictive pour l\'instant)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Modifier mon Profil'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Nouveau Nom Utilisateur'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: biographieController,
              decoration: const InputDecoration(labelText: 'Biographie'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _mettreAJourProfil,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}