const String tableville = 'Villes';

class VilleFields {
  static const List<String> values = [
    id, nom
  ];

  static const String id = 'id';
  static const String nom = 'nom';
}

class Ville {
  final int? id;
  final String nom;

  const Ville({
    this.id,
    required this.nom
  });

  Ville copy({
    int? id,
    String? nom,
  }) =>
      Ville(
        id: id ?? this.id,
        nom: nom ?? this.nom,
      );

  static Ville fromJson(Map<String, Object?> json) => Ville(
    id: json[VilleFields.id] as int?,
    nom: json[VilleFields.nom] as String
  );

  Map<String, Object?> toJson() =>  {
    VilleFields.id: id,
    VilleFields.nom: nom,
  };

  int? get getId => id; // Définition du getter getId
}