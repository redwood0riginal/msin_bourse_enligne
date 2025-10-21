import 'package:flutter/material.dart';
import '../../models/market_summary.dart';
import '../../utils/formatters.dart';
import '../../config/theme.dart';

class StockDetailsScreen extends StatefulWidget {
  final MarketSummary instrument;

  const StockDetailsScreen({super.key, required this.instrument});

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color:
                isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            Text(
              widget.instrument.symbol ?? 'N/A',
              style: TextStyle(
                color:
                    isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.instrument.symbol ?? 'N/A',
              style: TextStyle(
                color:
                    isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.instrument.name ?? 'N/A',
              style: TextStyle(
                color:
                    isDarkMode
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
