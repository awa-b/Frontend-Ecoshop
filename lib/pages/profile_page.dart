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

  Future<void> _chargerProfil() async {
    final authService = AuthService(); // <- ici on crée une instance
    final response = await authService.profil(widget.tokenAcces); // <- on passe le tokenAcces

    if (response.statusCode == 200) {
      final data = response.body;
      setState(() {
        email = data.toString(); // (Tu pourras améliorer plus tard l'affichage)
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
      ),
      body: Center(
        child: Text(
          'Email : $email',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}