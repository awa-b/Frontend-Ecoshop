import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  final String tokenAcces;

  const ProfilePage({Key? key, required this.tokenAcces}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String username = '';
  int points = 0;

  Future<void> _chargerProfil() async {
    final authService = AuthService();
    final response = await authService.profil(widget.tokenAcces);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        email = data['email'];
        username = data['nom_utilisateur'];
        points = data['points'];
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
    final tailleEcran = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: email.isEmpty
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: tailleEcran.width < 600 ? 400 : 500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nom Utilisateur : $username',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Email : $email',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Points : $points',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/modif_profil');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(tailleEcran.width < 600 ? 150 : 200, 50),
                            backgroundColor: Colors.black,
                          ),
                          child: const Text('Modifier le Profil'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/history');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(tailleEcran.width < 600 ? 150 : 200, 50),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Voir l\'Historique'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}