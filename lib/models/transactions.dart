// Une classe Transaction avec tous les champs non obligatoires et non obligatoires dans le constructeur
class transaction {
  String? id = "";
  // Les champs de la classe
  DateTime? date = DateTime
      .now(); // La date de la transaction, par défaut la date et l'heure actuelles
  bool?
      isValid; // Un booléen indiquant si la transaction est valide ou non, par défaut false
  double? montant; // Le montant de la transaction, par défaut 0
  String?
      nom_OM_MOMO; // Le nom du destinataire ou de l'émetteur de la transaction, par défaut vide
  String?
      numero_OM_MOMO; // Le numéro du destinataire ou de l'émetteur de la transaction, par défaut vide
  String? reseau; // Le réseau utilisé pour la transaction, par défaut vide
  String? tel; // Le numéro de téléphone de l'utilisateur, par défaut vide
  String? type; // Le type de la transaction, par défaut "retrait"
  String? utilisateur; // L'email de l'utilisateur, par défaut vide

  // Le constructeur de la classe, avec des paramètres nommés et des valeurs par défaut
  transaction({
    this.date,
    this.isValid = false,
    this.montant = 0.0001,
    this.nom_OM_MOMO = "",
    this.numero_OM_MOMO = "",
    this.reseau = "",
    this.tel = "",
    this.type = "retrait",
    this.utilisateur = "",
  });

  // Une méthode toJson qui retourne un Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'is_valid': isValid,
      'montant': montant,
      'nom_OM_MOMO': nom_OM_MOMO,
      'numero_OM_MOMO': numero_OM_MOMO,
      'reseau': reseau,
      'tel': tel,
      'type': type,
      'utilisateur': utilisateur,
    };
  }
}
