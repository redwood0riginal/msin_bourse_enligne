import 'package:flutter/material.dart';
import '../../utils/formatters.dart';
import '../../config/theme.dart';
import '../../models/portfolio_position.dart';

class PositionCard extends StatelessWidget {
  final PortfolioPosition position;

  const PositionCard({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isPositivePerformance = position.performance >= 0;
    final isPositiveLatente = position.valuesLatentes >= 0;

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
            // Header with Libelle and Performance badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    position.libelle,
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositivePerformance
                            ? AppColors.success
                            : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositivePerformance
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 12,
                        color: isPositivePerformance
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        Formatters.formatPercent(position.performance.abs()),
                        style: TextStyle(
                          color: isPositivePerformance
                              ? AppColors.success
                              : AppColors.error,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Grid of attributes
            _buildAttributeRow(
              isDarkMode: isDarkMode,
              label1: 'Quantité',
              value1: position.quantity.toString(),
              label2: 'CMP net',
              value2: Formatters.formatNumber(position.cmpNet),
            ),
            const SizedBox(height: 12),
            _buildAttributeRow(
              isDarkMode: isDarkMode,
              label1: 'Cours marché',
              value1: Formatters.formatNumber(position.coursMarche),
              label2: 'Valorisation',
              value2: Formatters.formatNumber(position.valorisation),
            ),
            const SizedBox(height: 12),
            _buildAttributeRow(
              isDarkMode: isDarkMode,
              label1: 'Values latentes',
              value1: Formatters.formatNumber(position.valuesLatentes),
              label2: 'Poids',
              value2: '${position.poids.toStringAsFixed(2)}%',
              isValue1Colored: true,
              value1Color: isPositiveLatente
                  ? AppColors.success
                  : AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeRow({
    required bool isDarkMode,
    required String label1,
    required String value1,
    required String label2,
    required String value2,
    bool isValue1Colored = false,
    Color? value1Color,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildAttribute(
            isDarkMode: isDarkMode,
            label: label1,
            value: value1,
            isColored: isValue1Colored,
            valueColor: value1Color,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildAttribute(
            isDarkMode: isDarkMode,
            label: label2,
            value: value2,
          ),
        ),
      ],
    );
  }

  Widget _buildAttribute({
    required bool isDarkMode,
    required String label,
    required String value,
    bool isColored = false,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDarkMode
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isColored
                ? valueColor
                : (isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
