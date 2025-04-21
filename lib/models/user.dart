class Utilisateur {
  final String email;
  final String nomUtilisateur;
  final int points;

  Utilisateur({
    required this.email,
    required this.nomUtilisateur,
    required this.points,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      email: json['email'],
      nomUtilisateur: json['nom_utilisateur'],
      points: json['points'],
    );
  }
}