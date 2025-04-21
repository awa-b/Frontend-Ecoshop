import 'dart:convert'; // Nécessaire pour jsonEncode
import 'package:http/http.dart' as http;
import 'package:ecoshop_flutter/api/api.dart'; 

class AuthService {
  // Inscription
  Future<http.Response> inscription(
    String email,
    String username,
    String motDePasse,
    String confirmerMotDePasse,
  ) async {
    final response = await http.post(
      Uri.parse(Api.inscription),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'username': username,
        'mot_de_passe': motDePasse,
        'confirmation_mot_de_passe': confirmerMotDePasse,
      }),
    );
    return response;
  }

  // Connexion
  Future<http.Response> connexion(String email, String motDePasse) async {
    final response = await http.post(
      Uri.parse(Api.connexion),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'mot_de_passe': motDePasse,
      }),
    );
    return response;
  }

  // Profil
  Future<http.Response> profil(String tokenAcces) async {
    final response = await http.get(
      Uri.parse(Api.profil),
      headers: {
        'Authorization': 'Bearer $tokenAcces',
        'Content-Type': 'application/json', // Optionnel mais souvent recommandé
      },
    );

    if (response.statusCode == 200) {
      // Si la requête réussit, tu peux traiter la réponse ici.
      print('Profil récupéré avec succès');
    } else {
      // Si la requête échoue, tu peux gérer les erreurs ici.
      print('Erreur lors de la récupération du profil');
    }

    return response;
  }
Future<http.Response> updateProfile({
    required String token,
    required String email,
    required String username,
    String? password,
  }) async {
    final Map<String, dynamic> body = {
      'email': email,
      'username': username,
    };

    // Ajouter le mot de passe si fourni
    if (password != null && password.isNotEmpty) {
      body['mot_de_passe'] = password;
      body['confirmation_mot_de_passe'] = password; // Facultatif selon ton API
    }
    print('Token envoyé: $token');
    try {
      final response = await http.put(
        Uri.parse(Api.modifierProfil), // Assure-toi que cette URL est correcte
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),  // Encodage des données en JSON
      );

      if (response.statusCode == 200) {
        print('Profil mis à jour avec succès');
      } else {
        print('Erreur lors de la mise à jour du profil: ${response.body}');
      }

      return response;
    } catch (e) {
      print('Erreur lors de la mise à jour du profil: $e');
      rethrow;  // Propager l'exception
    }
  }
}

