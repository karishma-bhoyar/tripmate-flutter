import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_bloc.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_event.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_state.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';
import 'package:flutter_application_tripmate/widgets/common/shimmer_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedHotels extends StatefulWidget {
  const RecommendedHotels({super.key});

  @override
  State<RecommendedHotels> createState() => _RecommendedHotelsState();
}

class _RecommendedHotelsState extends State<RecommendedHotels> {
  @override
  void initState() {
    super.initState();
    context.read<HotelsBloc>().add(const FetchHotelsEvent('All Destinations'));
  }

  static const List<HotelData> fallbackData = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Recommended Hotels", onSeeAllTap: () {}),
        const SizedBox(height: AppSizes.spacing16),
        BlocBuilder<HotelsBloc, HotelsState>(
          builder: (context, state) {
            List<HotelData> hotels = fallbackData;
            if (state is HotelsLoaded) {
              hotels = state.hotels;
            }

            if (state is HotelsLoading) {
              return const Column(
                children: [HotelCardSkeleton(), HotelCardSkeleton()],
              );
            }

            return Column(
              children: hotels
                  .map(
                    (hotel) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: AppSizes.spacing16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radius16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: HotelCard(hotel: hotel),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
