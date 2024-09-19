import 'package:flutter/material.dart';

import '../../../../models/country.dart';

class SignUpProvider with ChangeNotifier {
  late final List<Country> countries;

  Image getImage(String countryCode) => Image.asset('icons/flags/png100px/$countryCode.png', package: 'country_icons');


  SignUpProvider({BuildContext? context} ) {
    _initializeCountries(context!);
  }

  void _initializeCountries(BuildContext context) {
    countries = [
      Country(
        name: "USA",
        code: '+1',
        isoCode: 'us',
      ),
      Country(
        name: "India",
        code: '+91',
        isoCode: 'in',
      ),
      Country(
        name: "Canada",
        code: '+1',
        isoCode: 'ca',
      ),
      Country(
        name:"Malsayia",
        code: '+60',
        isoCode: 'my',
      ),
      Country(
        name: "Japan",
        code: '+81',
        isoCode: 'jp',
      ),
      Country(
        name: "Indonesia",
        code: '+62',
        isoCode: 'id',
      ),
      Country(
        name: "Taiwan",
        code: '+886',
        isoCode: 'tw',
      ),
      Country(
        name:"Thailand",
        code: '+66',
        isoCode: 'th',
      ),
      Country(
        name: "Singapore",
        code: '+65',
        isoCode: 'sg',
      ),
      Country(
        name:"Philippines",
        code: '+63',
        isoCode: 'ph',
      ),
      Country(
        name: "New_zealand",
        code: '+64',
        isoCode: 'nz',
      ),
      Country(
        name: "South korea",
        code: '+82',
        isoCode: 'kr',
      ),
      Country(
        name: "Australia",
        code: '+61',
        isoCode: 'au',
      ),
    ];
  }

  final signUpFormKey = GlobalKey<FormState>();
  String? email;
  String? token;
  String? countryCode;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  bool agreeToTerms = false;
  bool usePhoneNumber = true;
  bool isLoading = false;

  bool get canSubmit {
    final valid = agreeToTerms && password == confirmPassword && (signUpFormKey.currentState?.validate() ?? false);
    return valid;
  }

  void toggleAgreeToTerms(bool? value) {
    agreeToTerms = value ?? false;
    validateForm();
  }

  void toggleLayout() {
    usePhoneNumber = !usePhoneNumber;
    notifyListeners();
  }

  void validateForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


}
