class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Rescue Animals',
    image: 'rescue.png',
    description:
        "Help save animals in need and provide them with the care they deserve.",
  ),
  OnboardingContent(
    title: 'Adopt a Friend',
    image: 'adoption.jpg',
    description:
        "Find your perfect furry companion and give them a second chance at life.",
  ),
  OnboardingContent(
    title: 'Help Your Pet Find a New Home',
    image: 'lovinghome.png',
    description:
        "Offer a safe, loving home to pets who are waiting for a family like yours.",
  ),
];
