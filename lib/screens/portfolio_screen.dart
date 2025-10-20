import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_rounded,
            size: 80,
            color: isDarkMode
                ? Colors.white.withOpacity(0.3)
                : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 24),
          Text(
            'Portefeuille',
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xFF0A0E21),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Contenu à venir',
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.5)
                  : const Color(0xFF64748B),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
