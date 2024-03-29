class USER {
  String? email = '';
  String? password = '';
  String? uid;
  String? tel;
  String? codeParrainage;
  bool? est_parrainee;
  String? email_parrain;
  int? nb_parrainage = 0;
  double? soldeBchain = 0.0001;
  double? soldeHiving = 0.0001;
  double? gainBchain = 0.0001;
  double? gainHiving = 0.0001;
  double? gainParrainage = 0.0001;

  USER({
    this.uid,
    this.email,
    this.codeParrainage,
    this.email_parrain,
    this.est_parrainee,
    this.nb_parrainage,
    this.soldeBchain,
    this.soldeHiving,
    this.tel,
    this.gainBchain,
    this.gainHiving,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'tel': tel,
      'codeParrainage': codeParrainage,
      'est_parrainee': est_parrainee,
      'email_parrain': email_parrain,
      'nb_parrainage': nb_parrainage,
      'soldeBchain': soldeBchain,
      'gainBchain': gainBchain,
      'gainHiving': gainHiving,
      'gainParrainage': gainParrainage,
    };
  }
}
