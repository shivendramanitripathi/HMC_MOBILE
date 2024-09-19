class RegexCosnt {
  String gstRegex =
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
  String mobRegx = r'^(?:[+0]9)?[0-9]{10}$';
  String emailRegx = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  String panRegx = '[A-Z]{5}[0-9]{4}[A-Z]{1}';
  String pinCode = r'^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
}
