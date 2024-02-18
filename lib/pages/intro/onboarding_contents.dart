class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Faites travailler votre argent ",
    image: "assets/images/image1.png",
    desc: "L'argent que vous investissez , est mis dans des évènements crypto.",
  ),
  OnboardingContents(
    title: "Observez vos resultats",
    image: "assets/images/image2.png",
    desc:
        "Recevez vos gains instantanément(chaque jour) sur trading. Stackez et Préparez votre halving des notres.",
  ),
  OnboardingContents(
    title: "Soyez avertis au moindre changement",
    image: "assets/images/image3.png",
    desc: "Sur Earn For all vous êtes informés de tout !",
  ),
];
