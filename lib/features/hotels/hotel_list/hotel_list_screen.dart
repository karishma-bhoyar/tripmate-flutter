import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart';
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart';
import 'package:flutter_application_tripmate/view/auth/widget/custom_terxtfield.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_chip.dart';

@RoutePage()
class HotelListScreen extends StatefulWidget {
  final DestinationModel destination;
  const HotelListScreen({super.key, required this.destination});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSort = 'Recommended';
  double _minRating = 0.0;

  List<HotelData> get _filtersHotels {
    List<HotelData> list = _allHotels.where((hotel) {
      final matchesDestination = hotel.location.toLowerCase().contains(
        widget.destination.name.toLowerCase(),
      );

      final matchesSearch =
          hotel.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hotel.location.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchRating = hotel.rating >= _minRating;
      return matchesDestination && matchesSearch && matchRating;
    }).toList();

    if (list.isEmpty) {
      list = _allHotels.where((hotel) {
        final matchesSearch =
            hotel.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            hotel.location.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchRating = hotel.rating >= _minRating;
        return matchesSearch && matchRating;
      }).toList();
    }

    if (_selectedSort == "Price : Low to High") {
      list.sort((a, b) {
        final priceA = int.parse(a.price.replaceAll(RegExp(r'[^0-9]'), ''));
        final priceB = int.parse(b.price.replaceAll(RegExp(r'[^0-9]'), ''));
        return priceA.compareTo(priceB);
      });
    } else if (_selectedSort == "Price : High to Low") {
      list.sort((a, b) {
        final priceA = int.parse(a.price.replaceAll(RegExp(r'[^0-9]'), ''));
        final priceB = int.parse(b.price.replaceAll(RegExp(r'[^0-9]'), ''));
        return priceB.compareTo(priceA);
      });
    } else if (_selectedSort == "Top Rated") {
      list.sort((a, b) {
        return b.rating.compareTo(a.rating);
      });
    }
    return list;
  }

  final List<HotelData> _allHotels = [
    // Bali Hotels
    const HotelData(
      id: 'hotel_1',
      imageUrl:
          "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=500&q=80",
      name: 'The Kayon Resort',
      location: "Ubud, Bali",
      rating: 4.7,
      reviews: 1240,
      price: "₹18,500",
    ),
    const HotelData(
      id: 'hotel_2',
      name: "Ayana Resort & Spa",
      location: "Jimbaran, Bali",
      rating: 4.8,
      reviews: 2150,
      price: "₹22,000",
      imageUrl:
          "https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=500&q=80",
    ),
    const HotelData(
      id: 'hotel_3',
      name: "Potato Head Suites",
      location: "Seminyak, Bali",
      rating: 4.5,
      reviews: 890,
      price: "₹15,000",
      imageUrl:
          "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=500&q=80",
    ),
    const HotelData(
      id: 'hotel_4',
      name: "Mandapa, A Ritz-Carlton",
      location: "Ubud, Bali",
      rating: 4.9,
      reviews: 640,
      price: "₹45,000",
      imageUrl:
          "https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&w=500&q=80",
    ),
    // Paris Hotels
    const HotelData(
      id: 'hotel_5',
      name: "Hotel Plaza Athénée",
      location: "Paris, France",
      rating: 4.8,
      reviews: 920,
      price: "₹42,000",
      imageUrl:
          "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80",
    ),
    const HotelData(
      id: 'hotel_6',
      name: "Le Meurice",
      location: "Paris, France",
      rating: 4.7,
      reviews: 580,
      price: "₹38,000",
      imageUrl:
          "https://images.unsplash.com/photo-1549294413-26f195afcbce?auto=format&fit=crop&w=500&q=80",
    ),
    // Tokyo Hotels
    const HotelData(
      id: 'hotel_6',
      name: "Park Hyatt Tokyo",
      location: "Shinjuku, Tokyo",
      rating: 4.8,
      reviews: 1150,
      price: "₹35,000",
      imageUrl:
          "https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=500&q=80",
    ),
    const HotelData(
      id: 'hotel_7',
      name: "Aman Tokyo",
      location: "Chiyoda, Tokyo",
      rating: 4.9,
      reviews: 720,
      price: "₹55,000",
      imageUrl:
          "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=500&q=80",
    ),
    // Switzerland Hotels
    const HotelData(
      id: 'hotel_8',
      name: "The Dolder Grand",
      location: "Zurich, Switzerland",
      rating: 4.8,
      reviews: 830,
      price: "₹48,000",
      imageUrl:
          "https://images.unsplash.com/photo-1502784444187-359ac186c5bb?auto=format&fit=crop&w=500&q=80",
    ),
    const HotelData(
      id: 'hotel_9',
      name: "Badrutt's Palace Hotel",
      location: "St. Moritz, Switzerland",
      rating: 4.9,
      reviews: 940,
      price: "₹62,000",
      imageUrl:
          "https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=500&q=80",
    ),
  ];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hotels = _filtersHotels;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: '${widget.destination.name} Hotels',
        subtitle: '${hotels.length} hotels found',
        onBackPressed: () => context.router.pop(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing24,
              vertical: AppSizes.spacing16,
            ),
            child: CustomTextField(
              controller: _searchController,
              hintText: "Search hotels in ${widget.destination.name}...",
              prefixIcon: Icons.search_rounded,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          _buildFilterChips(),
          Expanded(
            child: hotels.isEmpty
                ? Center(
                    child: Text(
                      "No hotels found",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      left: AppSizes.spacing24,
                      right: AppSizes.spacing24,
                      bottom: AppSizes.spacing32,
                    ),
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.spacing16),
                        child: HotelCard(hotel: hotels[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(
        left: AppSizes.spacing24,
        right: AppSizes.spacing24,
        bottom: AppSizes.spacing16,
      ),
      child: Row(
        children: [
          CustomChip(
            label: _selectedSort,
            icon: Icons.sort_rounded,
            onTap: () {
              _showSortSelector();
            },
            isActive: _selectedSort != "Recommended",
          ),
          const SizedBox(width: AppSizes.spacing8),
          CustomChip(
            label: _minRating > 0 ? "$_minRating+★" : "Rating",
            icon: Icons.star_rounded,
            onTap: () {
              setState(() {
                if (_minRating == 0.0) {
                  _minRating = 4.5;
                } else if (_minRating == 4.5) {
                  _minRating = 4.8;
                } else {
                  _minRating = 0.0;
                }
              });
            },
            isActive: _minRating > 0,
          ),
        ],
      ),
    );
  }

  void _showSortSelector() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radius24),
        ),
      ),
      context: context,
      builder: (context) {
        final options = [
          "Recommended",
          "Price : Low to High",
          "Price : High to Low",
          "Top Rated",
        ];
        return Container(
          padding: const EdgeInsets.all(AppSizes.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sort By",
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.spacing16),
              ...options.map((option) {
                final isSelected = _selectedSort == option;
                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.primaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedSort = option;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
