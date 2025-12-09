class Court {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int pricePerHour;
  final String imageUrl;
  final String description;
  final List<String> features;

  Court({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.pricePerHour,
    required this.imageUrl,
    required this.description,
    required this.features,
  });

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      rating: (json['rating'] as num).toDouble(),
      pricePerHour: json['pricePerHour'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      features: List<String>.from(json['features']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'pricePerHour': pricePerHour,
      'imageUrl': imageUrl,
      'description': description,
      'features': features,
    };
  }
}
