import 'package:flutter/material.dart';
import '../services/order_service.dart';
import 'dart:convert';

class OrderHistoryPage extends StatefulWidget {
  final String tokenAcces;

  const OrderHistoryPage({Key? key, required this.tokenAcces}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<dynamic> commandes = [];

  Future<void> chargerHistorique() async {
    final service = OrderService();
    final response = await service.historiqueCommandes(widget.tokenAcces);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        commandes = data;
      });
    } else {
      print('Erreur lors du chargement de l\'historique');
    }
  }

  @override
  void initState() {
    super.initState();
    chargerHistorique();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historique des commandes')),
      body: commandes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: commandes.length,
              itemBuilder: (context, index) {
                final commande = commandes[index];
                return ListTile(
                  title: Text('Commande #${commande['id']}'),
                  subtitle: Text('Total: ${commande['montant_total']} €'),
                );
              },
            ),
    );
  }
}