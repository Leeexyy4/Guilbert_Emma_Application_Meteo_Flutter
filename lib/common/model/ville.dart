const String tableville = 'Villes';

// Cette classe définit les constantes utilisées pour la gestion des noms de champs de la table Ville.
class VilleFields {
  // Liste des noms de champs utilisés dans la table Ville.
  static const List<String> values = [
    id, nom
  ];

  // Nom du champ "id" dans la table Ville.
  static const String id = 'id';

  // Nom du champ "nom" dans la table Ville.
  static const String nom = 'nom';
}

// Cette classe représente une ville avec ses attributs.
class Ville {
  // Identifiant de la ville.
  final int? id;

  // Nom de la ville.
  final String nom;

  // Constructeur de la classe Ville.
  const Ville({
    this.id,
    required this.nom
  });

  // Méthode de copie pour créer une nouvelle instance de Ville en modifiant certains attributs.
  Ville copy({
    int? id,
    String? nom,
  }) =>
      Ville(
        id: id ?? this.id,
        nom: nom ?? this.nom,
      );

  // Méthode statique pour créer une instance de Ville à partir de données JSON.
  static Ville fromJson(Map<String, Object?> json) => Ville(
      id: json[VilleFields.id] as int?,
      nom: json[VilleFields.nom] as String
  );

  // Méthode pour convertir une instance de Ville en données JSON.
  Map<String, Object?> toJson() =>  {
    VilleFields.id: id,
    VilleFields.nom: nom,
  };
}
