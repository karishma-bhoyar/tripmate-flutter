import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';

class ExploreFilterSheet extends StatefulWidget {
  final double initialMinPrice;
  final double initialMaxPrice;
  final String initialSortBy;
  final double initialMinRating;
  final String initialCategory;
  const ExploreFilterSheet({
    this.initialMinPrice = 5000,
    this.initialMaxPrice = 50000,
    this.initialSortBy = "Recommended",
    this.initialMinRating = 0.0,
    this.initialCategory = "All",
    super.key,
  });

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  late RangeValues _currentPriceRange;
  late double _selectedMinRating;
  late String _selectedCategory;
  late String _selectedSortOption;

  final List<Map<String, dynamic>> _ratingOptions = const [
    {
      'label': 'any',
      'value': 0.0,
      'icon': Icons.radio_button_unchecked_rounded,
    },
    {'label': '4.0+', 'value': 4.0, 'icon': Icons.star_border_rounded},
    {'label': '4.5+', 'value': 4.5, 'icon': Icons.star_border_rounded},
    {'label': '4.8+', 'value': 4.8, 'icon': Icons.star_border_rounded},
  ];
  final List<Map<String, String>> _categories = const [
    {"label": "All", "icon": ''},
    {"label": "Beach", "icon": AppAssets.beachCategory},
    {"label": "Mountain", "icon": AppAssets.mountainCategory},
    {"label": "City", "icon": AppAssets.cityCategory},
    {"label": "Adventure", "icon": AppAssets.adventureCategory},
  ];
  final List<String> _sortOption = const [
    "Recommended",
    "Price: Low to High",
    "Price: High to Low",
    "Top Rated",
  ];

  @override
  void initState() {
    _currentPriceRange = RangeValues(
      widget.initialMinPrice,
      widget.initialMaxPrice,
    );
    _selectedMinRating = widget.initialMinRating;
    _selectedCategory = widget.initialCategory;
    _selectedSortOption = widget.initialSortBy;
    super.initState();
  }

  void resetFilters() {
    setState(() {
      _currentPriceRange = RangeValues(5000, 50000);
      _selectedMinRating = 0.0;
      _selectedCategory = "All";
      _selectedSortOption = "Recommended";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radius24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.spacing12),
          Center(
            child: Container(
              width: AppSizes.spacing40,
              height: AppSizes.spacing4,
              decoration: BoxDecoration(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSizes.radius4),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacing12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spacing12),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacing24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Range',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.onDrag,
                      valueIndicatorColor: AppColors.primaryColor.withValues(
                        alpha: 0.15,
                      ),
                      valueIndicatorTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      valueIndicatorShape:
                          RectangularSliderValueIndicatorShape(),
                    ),
                    child: RangeSlider(
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.greyColor.withValues(
                        alpha: 0.15,
                      ),
                      labels: RangeLabels(
                        '₹${_currentPriceRange.start.round()}',
                        '₹${_currentPriceRange.end.round()}',
                      ),
                      min: 0,
                      max: 50000,
                      divisions: 50,
                      values: _currentPriceRange,
                      onChanged: (RangeValues value) {
                        setState(() {
                          _currentPriceRange = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '₹0',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹10k',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹20k',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹30k',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹40k',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹50k',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  Text(
                    "Minimum Rating",
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _ratingOptions.map((option) {
                        final isSelected =
                            _selectedMinRating == option['value'];
                        final label = option['label'].toString();
                        final icon = option['value'] == 0.0
                            ? option['icon'] as IconData
                            : (isSelected
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMinRating = option['value'] as double;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: AppSizes.spacing8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacing16,
                              vertical: AppSizes.spacing10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.greyColor.withValues(
                                        alpha: 0.15,
                                      ),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radius100,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  icon,
                                  size: AppSizes.spacing16,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : (option['value'] == 0.0
                                            ? AppColors.greyColor
                                            : Colors.amber),
                                ),
                                const SizedBox(width: AppSizes.spacing4),
                                Text(
                                  label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  Text(
                    "Category",
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _categories.map((category) {
                      final label = category['label']!;
                      final assestPath = category['icon']!;
                      final isSelected = _selectedCategory == label;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = label;
                          });
                        },
                        child: Container(
                          width: AppSizes.spacing64,
                          height: AppSizes.spacing64,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor.withValues(alpha: 0.15),
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSizes.radius12,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (assestPath.isEmpty)
                                Icon(
                                  Icons.grid_view_outlined,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor,
                                  size: AppSizes.icon20,
                                )
                              else
                                AppSvg(
                                  assetPath: assestPath,
                                  height: AppSizes.icon20,
                                  width: AppSizes.icon20,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor,
                                ),
                              const SizedBox(height: AppSizes.spacing4),
                              Text(
                                label,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  Text(
                    'Sort By',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing16,
                      vertical: AppSizes.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color: AppColors.greyColor.withValues(alpha: 0.15),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.radius12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSortOption,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.greyColor,
                        ),
                        items: _sortOption.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedSortOption = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacing32),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing24,
              vertical: AppSizes.spacing16,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.greyColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(AppSizes.spacing48),
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radius12,
                          ),
                        ),
                      ),

                      onPressed: resetFilters,
                      child: Text(
                        'Reset',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spacing16),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Apply Filters',
                      onPressed: () {
                        context.router.pop({
                          'minPrice': _currentPriceRange.start,
                          'maxPrice': _currentPriceRange.end,
                          'sortBy': _selectedSortOption,
                          'minRating': _selectedMinRating,
                          'category': _selectedCategory,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
