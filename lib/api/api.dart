class Api {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  static const String inscription = "$baseUrl/utilisateurs/inscription/";
  static const String connexion = "$baseUrl/utilisateurs/connexion/";
  static const String profil = "$baseUrl/utilisateurs/profil/";
  static const String commandes = "$baseUrl/utilisateurs/commandes/";
  static const String recherches = "$baseUrl/utilisateurs/recherches/";
  static const String changerMotDePasse = "$baseUrl/utilisateurs/changer-mot-de-passe/";
  static const String reinitialiserMotDePasse = "$baseUrl/utilisateurs/reinitialiser-mot-de-passe/";
  static const String modifierProfil = "$baseUrl/utilisateurs/modifier-profil/";
  static const String actualiserJeton = "$baseUrl/jeton/actualiser/";
}