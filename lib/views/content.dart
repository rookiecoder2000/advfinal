class OnBoardingContent {
  String image;
  String title;
  String description;

  OnBoardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
      title: 'Find A Cozy Place',
      image: 'assets/images/Sweethome.svg',
      description:
          "Become a renter and find a boarding house of your choice from verified Landlords"),
  OnBoardingContent(
      title: 'Earn money, Become a Landlord',
      image: 'assets/images/Money.svg',
      description:
          "Add your boarding house units in our listing for rent to verified individuals "),
  OnBoardingContent(
      title: 'One-stop Renting Application',
      image: 'assets/images/Charts.svg',
      description:
          "Manage your units efficiently, and standout from the business competition"),
];
