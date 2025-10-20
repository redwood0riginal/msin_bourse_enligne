import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0.00', 'fr_FR');
    return '${formatter.format(value)} MAD';
  }

  static String formatCompactCurrency(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(2)} Mds MAD';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} M MAD';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} K MAD';
    }
    return formatCurrency(value);
  }

  static String formatNumber(double value) {
    final formatter = NumberFormat('#,##0.00', 'fr_FR');
    return formatter.format(value);
  }

  static String formatPercent(double value) {
    final sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(2)}%';
  }

  static String formatVolume(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} K';
    }
    return value.toStringAsFixed(0);
  }
}
