import 'dart:convert'; // Importer jsonDecode
import 'package:flutter/material.dart';
import 'package:ecoshop_flutter/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  final String tokenAcces; // <- Ajouté !

  const ProfilePage({Key? key, required this.tokenAcces}) : super(key: key); // <- Modifié aussi !

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String username = '';
  int points = 0;

  Future<void> _chargerProfil() async {
    final authService = AuthService(); // <- ici on crée une instance
    final response = await authService.profil(widget.tokenAcces); // <- on passe le tokenAcces

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Décode la réponse JSON
      setState(() {
        email = data['email']; // Récupère l'email
        username = data['nom_utilisateur']; // Récupère le nom d'utilisateur
        points = data['points']; // Récupère les points
      });
    } else {
      print('Erreur lors du chargement du profil');
    }
  }

  @override
  void initState() {
    super.initState();
    _chargerProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
        backgroundColor: Colors.deepPurple, // Changer la couleur de l'appbar
      ),
      body: Center(
        child: email.isEmpty // Afficher un loader jusqu'à ce que l'email soit chargé
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Nom Utilisateur: $username',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Points: $points',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // Rediriger vers la page de modification du profil
                        Navigator.pushNamed(context, '/modif_profil');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Couleur du bouton
                      ),
                      child: Text('Modifier le Profil'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Rediriger vers la page de l'historique
                        Navigator.pushNamed(context, '/history');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Couleur du bouton
                      ),
                      child: Text('Voir l\'Historique'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
