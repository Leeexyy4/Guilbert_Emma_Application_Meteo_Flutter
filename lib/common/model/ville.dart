final String tableville = 'Villes';

class VilleFields {
  static final List<String> values = [
    id, ville
  ];

  static final String id = 'id';
  static final String ville = 'ville';
}

class Ville {
  final int? id;
  final String ville;

  const Ville({
    this.id,
    required this.ville
  });

  Ville copy({
    int? id,
    String? ville,
    }) =>
      Ville(
        id: id ?? this.id,
        ville: ville ?? this.ville
      );

  static Ville fromJson(Map<String, Object?> json) => Ville(
    id: json[VilleFields.id] as int?,
    ville: json[VilleFields.ville] as String
  );

  Map<String, Object?> toJson() =>  {
    VilleFields.id: id,
    VilleFields.ville: ville,
  };

}