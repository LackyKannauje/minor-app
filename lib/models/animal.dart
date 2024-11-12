class Animal {
  final String name;
  final String description;

  Animal({required this.name, required this.description});


  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      description: json['description'],
    );
  }
}
