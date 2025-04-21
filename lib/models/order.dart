class Order {
  final String nomProduit;
  final int quantite;
  final double prix;
  final String dateCommande;

  Order({
    required this.nomProduit,
    required this.quantite,
    required this.prix,
    required this.dateCommande,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      nomProduit: json['nom_produit'],
      quantite: json['quantite'],
      prix: double.parse(json['prix'].toString()),
      dateCommande: json['date_commande'],
    );
  }
}