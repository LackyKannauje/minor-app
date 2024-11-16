class Animal {
  final String category;
  final String description;
  final String status;
  final String? location;
  final String? contact;
  final String? image;

  Animal({
    required this.category,
    required this.description,
    required this.status,
    this.location,
    this.contact,
    this.image,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      category: json['category'],
      description: json['description'],
      status: json['status'],
      location: json['location'],
      contact: json['contact'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'status': status,
      'location': location,
      'contact': contact,
      'image': image,
    };
  }
}
