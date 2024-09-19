
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../app_configs/app_colors.dart';
import '../app_configs/app_images.dart';
import '../constants/app_sizes.dart';
import '../models/country.dart';

class CustomCountryCodeDropdown extends StatelessWidget {
  final List<Country> countries;
  final Country selectedCountry;
  final ValueChanged<Country?> onChanged;

  const CustomCountryCodeDropdown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: Sizes.p8),
      margin: const EdgeInsets.only(left: Sizes.p4, right: Sizes.p16),
      decoration: const BoxDecoration(
        color: AppColors.greyBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: DropdownButton<Country>(
                value: selectedCountry,
                onChanged: onChanged,
                items: countries.map((Country country) {
                  return DropdownMenuItem<Country>(
                    value: country,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/${country.isoCode}.svg',
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                        const SizedBox(width: Sizes.p8),
                        Text(
                          country.code,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                icon: Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    AppImages.arrowDownIcon,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
