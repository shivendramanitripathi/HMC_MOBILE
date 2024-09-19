import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/utils/string_hardcoded_ext.dart';

import '../../../models/country.dart';

class CustomPhoneNumberFieldProvider with ChangeNotifier {
  final List<Country> countries;
  Country selectedCountry;
  final TextEditingController phoneNumberController = TextEditingController();
  final Function(String)? onChanged;

  CustomPhoneNumberFieldProvider({required this.countries, this.onChanged}) : selectedCountry = countries.first {
    phoneNumberController.addListener(_onPhoneNumberChanged);
  }

  void setSelectedCountry(Country? country) {
    if (country != null) {
      selectedCountry = country;
      notifyListeners();
    }
  }

  void _onPhoneNumberChanged() {
    onChanged?.call(phoneNumberController.text);
    notifyListeners();
  }

  String getPhoneNumberWithCountryCode() {
    return '${selectedCountry.code}-${phoneNumberController.text}';
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number'.hardcoded;
    }
    return null;
  }

  @override
  void dispose() {
    phoneNumberController.removeListener(_onPhoneNumberChanged);
    phoneNumberController.dispose();
    super.dispose();
  }
}
