class FavoriteModel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final String category;
  FavoriteModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'rating': rating,
      'category': category,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      name: map['name'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      rating: (map['rating'] as num).toDouble(),
      category: map['category'] as String,
    );
  }
}
