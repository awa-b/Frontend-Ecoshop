import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final tokenAcces = args['tokenAcces'];

    final List<Product> products = [
      Product(id: 1, name: "Produit A", description: "Description A", price: 10, imageUrl: ""),
      Product(id: 2, name: "Produit B", description: "Description B", price: 20, imageUrl: ""),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: {'tokenAcces': tokenAcces});
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history', arguments: {'tokenAcces': tokenAcces});
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search', arguments: {'tokenAcces': tokenAcces});
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.price} €'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}