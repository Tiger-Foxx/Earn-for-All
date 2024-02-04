class USER {
  String? email = '';
  String? password = '';
  String? uid;
  String? tel;
  String? codeParrainage;
  bool? est_parrainee;
  String? email_parrain;
  int? nb_parrainage = 0;
  int? soldeBchain = 0;
  int? soldeHiving = 0;
  int? gainBchain = 0;
  int? gainHiving = 0;

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
}
