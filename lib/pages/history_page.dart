import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Mon Historique'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text('Commandes passées'),
            onTap: () {
              Navigator.pushNamed(context, '/order_history');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.search, color: Colors.green),
            title: const Text('Historique de recherches'),
            onTap: () {
              Navigator.pushNamed(context, '/search_history');
            },
          ),
        ],
      ),
    );
  }
}