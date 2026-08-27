import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/features/notifications/presentation/notification_overlay_sheet.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/explore/widgets/explore_filter_sheet.dart';
import 'package:flutter_application_tripmate/features/home/widgets/recommended_hotels.dart';
import 'package:flutter_application_tripmate/view/auth/widget/custom_terxtfield.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';
import 'package:flutter_application_tripmate/widgets/main_layout.dart';
import 'package:flutter_application_tripmate/features/explore/widgets/explore_destination_card.dart';

class ExploreDestination {
  final String imageUrl;
  final String name;
  final String location;
  final double rating;
  final String category;
  final double price;

  const ExploreDestination({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
    required this.price,
  });
}

@RoutePage()
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  double _minPrice = 5000;
  double _maxPrice = 50000;
  double _minRating = 0.0;
  String _sortBy = 'Recommended';

  static const List<ExploreDestination> exploreDestination = [
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=500&q=80',
      name: 'Bali',
      location: 'Indonesia',
      rating: 4.8,
      category: 'Beach',
      price: 35000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?auto=format&fit=crop&w=500&q=80',
      name: 'Maldives',
      location: 'South Asia',
      rating: 4.9,
      category: 'Beach',
      price: 48000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80',
      name: 'Paris',
      location: 'France',
      rating: 4.7,
      category: 'City',
      price: 10000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=500&q=80',
      name: 'Tokyo',
      location: 'Japan',
      rating: 4.6,
      category: 'City',
      price: 20000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=500&q=80',
      name: 'Dubai',
      location: 'UAE',
      rating: 4.8,
      category: 'City',
      price: 25000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=500&q=80',
      name: 'Switzerland',
      location: 'Alps, Europe',
      rating: 4.9,
      category: 'Mountain',
      price: 42000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=500&q=80',
      name: 'Manali',
      location: 'Himachal Pradesh, India',
      rating: 4.5,
      category: 'Mountain',
      price: 8000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=500&q=80',
      name: 'Queenstown',
      location: 'New Zealand',
      rating: 4.9,
      category: 'Adventure',
      price: 38000,
    ),
    ExploreDestination(
      imageUrl:
          'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=500&q=80',
      name: 'Costa Rica',
      location: 'Central America',
      rating: 4.7,
      category: 'Adventure',
      price: 29000,
    ),
  ];

  final List<Map<String, String>> _categories = const [
    {"label": "All", "icon": ''},
    {"label": "Beach", "icon": AppAssets.beachCategory},
    {"label": "Mountain", "icon": AppAssets.mountainCategory},
    {"label": "City", "icon": AppAssets.cityCategory},
    {"label": "Adventure", "icon": AppAssets.adventureCategory},
  ];
  int _selectedCategoryIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    // Filter destinations dynamically by category selection and search query
    final filteredDestinations = exploreDestination.where((d) {
      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          d.category.toLowerCase() ==
              _categories[_selectedCategoryIndex]["label"]!.toLowerCase();
      final matchesSearch =
          query.isEmpty ||
          d.name.toLowerCase().contains(query) ||
          d.location.toLowerCase().contains(query);
      final matchPrice = d.price >= _minPrice && d.price <= _maxPrice;
      final matchRating = d.rating >= _minRating;
      return matchesCategory && matchesSearch && matchPrice && matchRating;
    }).toList();

    // 2. Result list ko selection ke according sort karein
    if (_sortBy == "Price: Low to High") {
      filteredDestinations.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == "Price: High to Low") {
      filteredDestinations.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == "Top Rated") {
      filteredDestinations.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return MainLayout(
      currentIndex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppSizes.spacing24),
            _buildSearchAndFilter(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              onFilterTap: () async {
                final result = await showModalBottomSheet<Map<String, dynamic>>(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ExploreFilterSheet(
                    initialMinPrice: _minPrice,
                    initialMaxPrice: _maxPrice,
                    initialSortBy: _sortBy,
                    initialMinRating: _minRating,
                    initialCategory:
                        _categories[_selectedCategoryIndex]['label']!,
                  ),
                );
                if (result != null) {
                  setState(() {
                    _minPrice = result["minPrice"] ?? 5000.0;
                    _maxPrice = result["maxPrice"] ?? 50000.0;
                    _sortBy = result['sortBy'] ?? 'Recommended';
                    _minRating = result['minRating'] ?? 0.0;
                    final categoryName = result['category'] ?? 'All';
                    final categoryIndex = _categories.indexWhere(
                      (c) =>
                          c['label']!.toLowerCase() ==
                          categoryName.toLowerCase(),
                    );
                    if (categoryIndex != -1) {
                      _selectedCategoryIndex = categoryIndex;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: AppSizes.spacing24),
            _buildExploreCategoryList(
              categories: _categories,
              selectedIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),
            const SizedBox(height: AppSizes.spacing24),
            SectionHeader(
              title: "Popular Destinations",
              onSeeAllTap: () {},
            ),
            const SizedBox(height: AppSizes.spacing16),
            _exploreDestinations(exploreDestinations: filteredDestinations),
            const SizedBox(height: AppSizes.spacing16),
            const RecommendedHotels(),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Explore', style: AppTextStyles.heading),
            const SizedBox(height: AppSizes.spacing4),
            Text(
              'Find your perfect destination',
              style: AppTextStyles.body.copyWith(color: AppColors.greyColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      const SizedBox(width: AppSizes.spacing16),
      Row(
        children: [
          InkWell(
            onTap: () => NotificationOverlaySheet.show(context),
            borderRadius: BorderRadius.circular(AppSizes.radius100),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.spacing10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withValues(alpha: 0.03),
                    blurRadius: AppSizes.spacing8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AppSvg(
                assetPath: AppAssets.notificationIcon,
                height: AppSizes.icon20,
                width: AppSizes.icon20,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildSearchAndFilter({
  required TextEditingController controller,
  required ValueChanged<String> onChanged,
  required VoidCallback onFilterTap,
}) {
  return CustomTextField(
    controller: controller,
    onChanged: onChanged,
    hintText: 'Search destinations, hotels...',
    prefixIcon: Icons.search_rounded,
    suffixIcon: InkWell(
      onTap: onFilterTap,
      borderRadius: BorderRadius.circular(AppSizes.spacing12),
      child: Container(
        margin: const EdgeInsets.all(AppSizes.spacing8),
        padding: const EdgeInsets.all(AppSizes.spacing8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSizes.radius12),
        ),
        child: AppSvg(
          assetPath: AppAssets.filterIcon,
          height: AppSizes.icon18,
          width: AppSizes.icon18,
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );
}

Widget _buildExploreCategoryList({
  required List<Map<String, String>> categories,
  required int selectedIndex,
  required Function(int) onCategorySelected,
}) {
  return SizedBox(
    height: AppSizes.categoryChipHeight,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final isSelected = selectedIndex == index;
        final category = categories[index];
        final assetsPath = category["icon"];
        return GestureDetector(
          onTap: () {
            onCategorySelected(index);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(right: AppSizes.spacing12),
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacing16,
              vertical: AppSizes.spacing8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.greyColor.withValues(alpha: 0.15),
                width: 1.2,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                else
                  BoxShadow(
                    color: AppColors.blackColor.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (assetsPath != null && assetsPath.isNotEmpty)
                  AppSvg(
                    assetPath: assetsPath,
                    height: AppSizes.icon18,
                    width: AppSizes.icon18,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                  )
                else
                  Icon(
                    Icons.grid_view_rounded,
                    size: AppSizes.icon18,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                  ),
                const SizedBox(width: AppSizes.spacing8),
                Text(
                  category["label"]!,
                  style: AppTextStyles.caption.copyWith(
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget _exploreDestinations({
  required List<ExploreDestination> exploreDestinations,
}) {
  return SizedBox(
    height: AppSizes.exploreDestinationCardHeight,
    child: exploreDestinations.isEmpty
        ? Center(
            child: Text(
              'No destinations found in this category',
              style: AppTextStyles.caption.copyWith(color: AppColors.greyColor),
            ),
          )
        : ListView.builder(
            clipBehavior: Clip.none,
            itemCount: exploreDestinations.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final destination = exploreDestinations[index];
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.spacing16),
                child: ExploreDestinationCard(destination: destination),
              );
            },
          ),
  );
}
