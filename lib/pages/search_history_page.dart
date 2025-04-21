import 'package:flutter/material.dart';
import '../services/search_service.dart';
import 'dart:convert';

class SearchHistoryPage extends StatefulWidget {
  final String tokenAcces;

  const SearchHistoryPage({Key? key, required this.tokenAcces}) : super(key: key);

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  List<dynamic> recherches = [];

  Future<void> chargerHistorique() async {
    final service = SearchService();
    final response = await service.historiqueRecherches(widget.tokenAcces);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        recherches = data;
      });
    } else {
      print('Erreur lors du chargement de l\'historique de recherches');
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
      appBar: AppBar(title: const Text('Historique des recherches')),
      body: recherches.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recherches.length,
              itemBuilder: (context, index) {
                final recherche = recherches[index];
                return ListTile(
                  title: Text(recherche['terme_recherche']),
                  subtitle: Text('Date: ${recherche['date']}'),
                );
              },
            ),
    );
  }
}