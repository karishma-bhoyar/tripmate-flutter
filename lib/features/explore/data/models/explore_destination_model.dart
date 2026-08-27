class ExploreDestinationModel {
  final String imageUrl;
  final String name;
  final String location;
  final double rating;
  final String category;
  final double price;

  const ExploreDestinationModel({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
    required this.price,
  });

  factory ExploreDestinationModel.fromJson(Map<String, dynamic> json) {
    return ExploreDestinationModel(
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] ?? 'All',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'location': location,
      'rating': rating,
      'category': category,
      'price': price,
    };
  }
}
