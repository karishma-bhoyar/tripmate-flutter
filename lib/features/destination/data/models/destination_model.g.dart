// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationModel _$DestinationModelFromJson(Map<String, dynamic> json) =>
    DestinationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$DestinationModelToJson(DestinationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
    };
