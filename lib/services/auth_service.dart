import 'package:http/http.dart' as http;
import 'package:ecoshop_flutter/api/api.dart';

class AuthService {
  Future<http.Response> inscription(String email, String motDePasse) async {
    final response = await http.post(
      Uri.parse(Api.inscription),
      body: {
        'email': email,
        'mot_de_passe': motDePasse,
      },
    );
    return response;
  }

  Future<http.Response> connexion(String email, String motDePasse) async {
    final response = await http.post(
      Uri.parse(Api.connexion),
      body: {
        'email': email,
        'mot_de_passe': motDePasse,
      },
    );
    return response;
  }

  Future<http.Response> profil(String tokenAcces) async {
    final response = await http.get(
      Uri.parse(Api.profil),
      headers: {
        'Authorization': 'Bearer $tokenAcces',
      },
    );
    return response;
  }
}