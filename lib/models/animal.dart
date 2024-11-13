class Animal {
  final String category; 
  final String description;

  Animal({required this.category, required this.description});

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      category: json['category'], 
      description: json['description'],
    );
  }
}
