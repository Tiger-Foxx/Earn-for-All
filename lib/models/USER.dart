class USER {
  String? email = '';
  String? password = '';
  String? uid;
  String? tel;
  String? codeParrainage;
  bool? est_parrainee;
  String? email_parrain;
  double? nb_parrainage = 0;
  double? soldeBchain = 0;
  double? soldeHiving = 0;
  double? gainBchain = 0;
  double? gainHiving = 0;
  double? gainParrainage = 0;

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
