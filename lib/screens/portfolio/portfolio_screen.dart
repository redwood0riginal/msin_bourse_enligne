import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/portfolio_data.dart';
import '../../models/portfolio_account.dart';
import '../../models/portfolio_position.dart';
import '../../widgets/portfolio/portfolio_summary_cards.dart';
import '../../widgets/portfolio/portfolio_pie_chart.dart';
import '../../widgets/portfolio/position_card.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late PortfolioData _portfolioData;
  String? _selectedAccountId;

  @override
  void initState() {
    super.initState();
    _loadPortfolioData();
  }

  void _loadPortfolioData() {
    _portfolioData = PortfolioData(
      valeurTotalePortefeuille: 1541261.03,
      valeurTotaleTitres: 340520.00,
      soldeEnEspeces: 1200741.03,
      accounts: [
        PortfolioAccount(
          accountId: '1',
          accountName: 'Compte1',
          positions: [
            PortfolioPosition(
              libelle: 'Attijariwafa Bank',
              quantity: 100,
              cmpNet: 520.00,
              coursMarche: 542.50,
              valorisation: 54250.00,
              valuesLatentes: 2250.00,
              performance: 4.33,
              poids: 35.20,
            ),
            PortfolioPosition(
              libelle: 'Maroc Telecom',
              quantity: 200,
              cmpNet: 125.00,
              coursMarche: 128.90,
              valorisation: 25780.00,
              valuesLatentes: 780.00,
              performance: 3.12,
              poids: 16.73,
            ),
            PortfolioPosition(
              libelle: 'BCP',
              quantity: 150,
              cmpNet: 280.00,
              coursMarche: 285.00,
              valorisation: 42750.00,
              valuesLatentes: 750.00,
              performance: 1.79,
              poids: 27.75,
            ),
          ],
        ),
        PortfolioAccount(
          accountId: '2',
          accountName: 'Compte2',
          positions: [
            PortfolioPosition(
              libelle: 'Label Vie',
              quantity: 50,
              cmpNet: 3800.00,
              coursMarche: 3850.00,
              valorisation: 192500.00,
              valuesLatentes: 2500.00,
              performance: 1.32,
              poids: 12.49,
            ),
            PortfolioPosition(
              libelle: 'CIH Bank',
              quantity: 80,
              cmpNet: 320.00,
              coursMarche: 315.50,
              valorisation: 25240.00,
              valuesLatentes: -360.00,
              performance: -1.41,
              poids: 1.64,
            ),
          ],
        ),
      ],
    );

    if (_portfolioData.accounts.isNotEmpty) {
      _selectedAccountId = _portfolioData.accounts.first.accountId;
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadPortfolioData();
    });
  }

  List<PortfolioPosition> _getSelectedPositions() {
    if (_selectedAccountId == null) return [];
    
    final account = _portfolioData.accounts.firstWhere(
      (acc) => acc.accountId == _selectedAccountId,
      orElse: () => _portfolioData.accounts.first,
    );
    
    return account.positions;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            PortfolioSummaryCards(
              valeurTotalePortefeuille: _portfolioData.valeurTotalePortefeuille,
              valeurTotaleTitres: _portfolioData.valeurTotaleTitres,
              soldeEnEspeces: _portfolioData.soldeEnEspeces,
              accounts: _portfolioData.accounts,
            ),
            const SizedBox(height: 16),

            // Pie Chart
            PortfolioPieChart(
              valeurTotaleTitres: _portfolioData.valeurTotaleTitres,
              soldeEnEspeces: _portfolioData.soldeEnEspeces,
            ),
            const SizedBox(height: 24),

            // Account Selector
            if (_portfolioData.accounts.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    'Positions',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedAccountId,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      items: _portfolioData.accounts.map((account) {
                        return DropdownMenuItem<String>(
                          value: account.accountId,
                          child: Text(account.accountName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAccountId = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Position Cards
              ..._getSelectedPositions().map((position) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PositionCard(position: position),
                );
              }),
            ],

            // Empty state if no positions
            if (_getSelectedPositions().isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.3)
                            : AppColors.textTertiaryLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucune position',
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
