import 'dart:convert'; // Nécessaire pour jsonDecode
import 'package:http/http.dart' as http;
import 'package:ecoshop_flutter/api/api.dart';

class UserService {
  Future<List<Product>> getProducts({String? apiKey}) async {
    // Crée l'URL avec paramètres
    Uri url = Uri.parse(Api.produits);
    if (apiKey != null) {
      url = url.replace(queryParameters: {'api_key': apiKey});
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> productData = jsonDecode(response.body);
      return productData.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

// Modèle représentant un produit
class Product {
  final String imageUrl;
  final String name;
  final String price;
  final double ecologicalRating;
  final String siteUrl;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.ecologicalRating,
    required this.siteUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageUrl: json['image'],
      name: json['nom'],
      price: json['prix'],
      ecologicalRating: (json['indice_ecolo'] as num).toDouble(), // Assure la conversion en double
      siteUrl: json['site_marchand'],
    );
  }
}
