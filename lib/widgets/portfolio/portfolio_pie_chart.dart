import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';

class PortfolioPieChart extends StatelessWidget {
  final double valeurTotaleTitres;
  final double soldeEnEspeces;

  const PortfolioPieChart({
    super.key,
    required this.valeurTotaleTitres,
    required this.soldeEnEspeces,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final total = valeurTotaleTitres + soldeEnEspeces;
    final double titresPercent = total > 0 ? (valeurTotaleTitres / total) * 100 : 0;
    final double especesPercent = total > 0 ? (soldeEnEspeces / total) * 100 : 0;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Répartition globale du portefeuille',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 3,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          if (titresPercent > 0)
                            PieChartSectionData(
                              value: titresPercent,
                              title: '${titresPercent.toStringAsFixed(1)}%',
                              color: AppColors.success,
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          if (especesPercent > 0)
                            PieChartSectionData(
                              value: especesPercent,
                              title: '${especesPercent.toStringAsFixed(1)}%',
                              color: AppColors.primary,
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Legend
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (especesPercent > 0)
                          _buildLegendItem(
                            isDarkMode: isDarkMode,
                            color: AppColors.primary,
                            label: 'ESPÈCES',
                            percent: especesPercent,
                          ),
                        if (titresPercent > 0 && especesPercent > 0)
                          const SizedBox(height: 16),
                        if (titresPercent > 0)
                          _buildLegendItem(
                            isDarkMode: isDarkMode,
                            color: AppColors.success,
                            label: 'TITRES',
                            percent: titresPercent,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required bool isDarkMode,
    required Color color,
    required String label,
    required num percent,
  }) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${percent.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
