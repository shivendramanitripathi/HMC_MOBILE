
import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/utils/string_hardcoded_ext.dart';
import 'package:provider/provider.dart';
import '../../../app_configs/app_colors.dart';
import '../../../models/country.dart';
import '../../country_code_dropdown.dart';
import 'custom_phone_number_field_provider.dart';

class CustomPhoneNumberField extends StatelessWidget {
  final List<Country> countries;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onChanged;
  const CustomPhoneNumberField({
    super.key,
    required this.countries,
    this.onSaved,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomPhoneNumberFieldProvider(
        countries: countries,
        onChanged: onChanged,
      ),
      child: Consumer<CustomPhoneNumberFieldProvider>(
        builder: (context, provider, _) => Stack(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: provider.phoneNumberController,
              keyboardType: TextInputType.phone,
              validator: provider.validatePhoneNumber,
              onSaved: (value) {
                onSaved?.call(provider.getPhoneNumberWithCountryCode());
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                ),
                hintText: 'Enter your phone number'.hardcoded,
                hintStyle: const TextStyle(color: AppColors.secondaryTextColor),
                prefixIcon: CustomCountryCodeDropdown(
                  countries: provider.countries,
                  selectedCountry: provider.selectedCountry,
                  onChanged: provider.setSelectedCountry,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
              style: const TextStyle(color: AppColors.secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
