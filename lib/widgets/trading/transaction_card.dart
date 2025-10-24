import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../models/user_transaction.dart';
import '../../utils/formatters.dart';

class TransactionCard extends StatelessWidget {
  final UserTransaction transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isAchat = transaction.sens == TransactionSens.achat;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

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
            // Header: Libelle, Sens badge, Type badge
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.libelle,
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'N° ${transaction.nOrder}',
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
                const SizedBox(width: 8),
                // Sens badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isAchat ? AppColors.success : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction.sensLabel,
                    style: TextStyle(
                      color: isAchat ? AppColors.success : AppColors.error,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // Type badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction.transactionTypeLabel,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dates and Type Order
            Row(
              children: [
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Date ordre',
                    value: dateFormat.format(transaction.dateOrder),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Type ordre',
                    value: transaction.typeOrderLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Cours and Quantities
            Row(
              children: [
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Cours',
                    value: Formatters.formatNumber(transaction.cours),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Qty total',
                    value: transaction.qtyTotal.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Executed and Remaining
            Row(
              children: [
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Qty exécuté',
                    value: transaction.qtyExecute.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Qty restant',
                    value: transaction.qtyRestant.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Statuts
            Row(
              children: [
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Statut sys',
                    value: transaction.statutSysLabel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAttribute(
                    isDarkMode: isDarkMode,
                    label: 'Statut marché',
                    value: transaction.statutMarcheLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Expiration date
            _buildAttribute(
              isDarkMode: isDarkMode,
              label: 'Date expiration',
              value: dateFormat.format(transaction.dateExpiration),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttribute({
    required bool isDarkMode,
    required String label,
    required String value,
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
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
