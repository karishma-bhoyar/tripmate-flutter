import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';

class RecommendedHotels extends StatelessWidget {
  const RecommendedHotels({super.key});
  static const List<HotelData> hotelData = [
    HotelData(
      id: 'hotel_1',
      imageUrl:
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80',
      name: 'Grand Hyatt Regency',
      location: 'Goa, India',
      rating: 4.7,
      reviews: 120,
      price: '₹12,000',
    ),
    HotelData(
      id: 'hotel_2',
      imageUrl:
          'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=500&q=80',
      name: 'Taj Palace Hotel',
      location: 'Mumbai, India',
      rating: 4.9,
      reviews: 250,
      price: '₹24,000',
    ),
    HotelData(
      id: 'hotel_3',
      imageUrl:
          'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=500&q=80',
      name: 'The Oberoi Amarvilas',
      location: 'Agra, India',
      rating: 4.8,
      reviews: 180,
      price: '₹35,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Recommended Hotels",
          onSeeAllTap: () {},
        ),
        const SizedBox(height: AppSizes.spacing16),
        Column(
          children: hotelData
              .map((hotel) => Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: AppSizes.spacing16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radius16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: HotelCard(hotel: hotel),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
