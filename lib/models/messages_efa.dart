// Une classe MessagesEFA avec tous les attributs non obligatoires
class MessagesEFA {
  // Les champs de la classe
  String? id; // L'ID du message, par défaut vide
  String? texte; // Le contenu du message, par défaut vide
  DateTime? date = DateTime
      .now(); // La date du message, par défaut la date et l'heure actuelles

  // Le constructeur de la classe, avec des paramètres nommés et des valeurs par défaut
  MessagesEFA({
    this.id = "",
    this.texte = "",
    this.date,
  });
}
