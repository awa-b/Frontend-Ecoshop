import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecoshop_flutter/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final UserService productService = UserService();
  List<Product> products = [];
  List<Product> filteredProducts = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Charger les produits depuis l'API
  Future<void> _loadProducts() async {
    try {
      final productsList = await productService.getProducts(apiKey: 'Ecoshop2025');
      setState(() {
        products = productsList;
        filteredProducts = productsList;
      });
    } catch (e) {
      print("Erreur de chargement des produits : $e");
    }
  }

  // Filtrer les produits
  void _filterProducts() {
    setState(() {
      filteredProducts = products
          .where((product) =>
              (selectedCategory == 'All' || product.name.contains(selectedCategory)) &&
              product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  // Naviguer vers la page de connexion ou d'inscription
  void _goToLogin() {
    Navigator.pushNamed(context, '/login'); // Remplacez '/login' par la route appropriée
  }

  void _goToProductDetail(Product product) {
    Navigator.pushNamed(context, '/productDetail', arguments: product);
  }

  // Fonction pour ouvrir un lien
  void _buyProduct(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Impossible d’ouvrir l’URL : $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecoshop'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _goToLogin, // Accéder à la page de connexion
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchQuery = value;
                _filterProducts();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              items: ['All', 'Electroménager', 'Vêtements', 'Accessoires', 'Mobilier']
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedCategory = value!;
                _filterProducts();
              },
              isExpanded: true,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 200),
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Prix : ${product.price.replaceAll('€', '')}€', style: TextStyle(fontSize: 14)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.eco, color: Colors.green, size: 18),
                                  Text(' ${product.ecologicalRating.toStringAsFixed(1)}/100'),
                                ],
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => _goToProductDetail(product),
                                  child: Text('Détails'),
                                ),
                                ElevatedButton(
                                  onPressed: () => _buyProduct(product.siteUrl),
                                  child: Text('Acheter'),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
