import 'package:flutter/material.dart';
import '../utils/formatters.dart';
import '../config/theme.dart';
import '../models/portfolio_account.dart';

class PortfolioSummaryCards extends StatelessWidget {
  final double valeurTotalePortefeuille;
  final double valeurTotaleTitres;
  final double soldeEnEspeces;
  final List<PortfolioAccount> accounts;

  const PortfolioSummaryCards({
    super.key,
    required this.valeurTotalePortefeuille,
    required this.valeurTotaleTitres,
    required this.soldeEnEspeces,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // First row - Valeur totale portefeuille (full width with gradient)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Valeur totale portefeuille',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  Formatters.formatCurrency(valeurTotalePortefeuille),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Second row - Horizontal scroll with full-width cards
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: _buildTitresCard(
                  context: context,
                  isDarkMode: isDarkMode,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: _buildMetricCard(
                  context: context,
                  isDarkMode: isDarkMode,
                  title: 'Solde en espèces',
                  value: Formatters.formatCurrency(soldeEnEspeces),
                  subtitle: 'Poids: ${((soldeEnEspeces / valeurTotalePortefeuille) * 100).toStringAsFixed(2)}%',
                  icon: Icons.payments_rounded,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitresCard({
    required BuildContext context,
    required bool isDarkMode,
  }) {
    // Calculate total value for each account
    Map<String, double> accountValues = {};
    for (var account in accounts) {
      double total = 0;
      for (var position in account.positions) {
        total += position.valorisation;
      }
      accountValues[account.accountName] = total;
    }

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.1)
              : AppColors.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Valeur totale\ntitres',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                // Comptes titres breakdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Comptes titres :',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...accountValues.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '${entry.key} : ${Formatters.formatNumber(entry.value)}',
                          style: TextStyle(
                            color: isDarkMode
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              Formatters.formatCurrency(valeurTotaleTitres),
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Poids: ${((valeurTotaleTitres / valeurTotalePortefeuille) * 100).toStringAsFixed(2)}%',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required bool isDarkMode,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.1)
              : AppColors.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
