import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String toCurrency({String currencyCode = 'USD', String locale = 'en_US'}) {
    String symbol;

    switch (currencyCode) {
      case 'USD':
        symbol = '\$';
        break;
      case 'EUR':
        symbol = '€';
        break;
      case 'GBP':
        symbol = '£';
        break;
      case 'INR':
        symbol = '₹';
        break;
      case 'JPY':
        symbol = '¥';
        break;
      case 'AUD':
        symbol = 'A\$';
        break;
      case 'CAD':
        symbol = 'C\$';
        break;
      case 'CNY':
        symbol = '¥';
        break;
      default:
        symbol = currencyCode;
    }

    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(this);
  }
}
