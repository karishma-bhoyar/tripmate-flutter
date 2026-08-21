import 'package:json_annotation/json_annotation.dart';

part 'destination_model.g.dart';

@JsonSerializable()
class DestinationModel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);
}
