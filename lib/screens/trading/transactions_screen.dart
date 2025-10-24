import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/user_transaction.dart';
import '../../widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionType? _selectedType;
  late List<UserTransaction> _allTransactions;
  late List<UserTransaction> _filteredTransactions;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    // Sample data - Replace with actual API calls
    _allTransactions = [
      UserTransaction(
        nOrder: 'ORD001234',
        libelle: 'Attijariwafa Bank',
        dateOrder: DateTime.now().subtract(const Duration(days: 2)),
        sens: TransactionSens.achat,
        cours: 542.50,
        qtyRestant: 0,
        qtyExecute: 100,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.totalementExecute,
        typeOrder: TypeOrder.limite,
        dateExpiration: DateTime.now().add(const Duration(days: 28)),
        transactionType: TransactionType.action,
      ),
      UserTransaction(
        nOrder: 'ORD001235',
        libelle: 'Maroc Telecom',
        dateOrder: DateTime.now().subtract(const Duration(days: 1)),
        sens: TransactionSens.vente,
        cours: 128.90,
        qtyRestant: 50,
        qtyExecute: 150,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.partialementExecute,
        typeOrder: TypeOrder.marche,
        dateExpiration: DateTime.now().add(const Duration(days: 27)),
        transactionType: TransactionType.action,
      ),
      UserTransaction(
        nOrder: 'ORD001236',
        libelle: 'FCP Dynamique',
        dateOrder: DateTime.now().subtract(const Duration(hours: 12)),
        sens: TransactionSens.achat,
        cours: 1250.00,
        qtyRestant: 20,
        qtyExecute: 0,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.partialementExecute,
        typeOrder: TypeOrder.limite,
        dateExpiration: DateTime.now().add(const Duration(days: 29)),
        transactionType: TransactionType.opcvm,
      ),
      UserTransaction(
        nOrder: 'ORD001237',
        libelle: 'BCP',
        dateOrder: DateTime.now().subtract(const Duration(days: 5)),
        sens: TransactionSens.achat,
        cours: 285.00,
        qtyRestant: 150,
        qtyExecute: 0,
        statutSys: StatutSys.annule,
        statutMarche: StatutMarche.annule,
        typeOrder: TypeOrder.seuil,
        dateExpiration: DateTime.now().subtract(const Duration(days: 1)),
        transactionType: TransactionType.action,
      ),
      UserTransaction(
        nOrder: 'ORD001238',
        libelle: 'OPV Société X',
        dateOrder: DateTime.now().subtract(const Duration(days: 3)),
        sens: TransactionSens.achat,
        cours: 450.00,
        qtyRestant: 0,
        qtyExecute: 200,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.totalementExecute,
        typeOrder: TypeOrder.marche,
        dateExpiration: DateTime.now().add(const Duration(days: 25)),
        transactionType: TransactionType.opv,
      ),
      UserTransaction(
        nOrder: 'ORD001239',
        libelle: 'Label Vie',
        dateOrder: DateTime.now().subtract(const Duration(hours: 6)),
        sens: TransactionSens.vente,
        cours: 3850.00,
        qtyRestant: 30,
        qtyExecute: 20,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.partialementExecute,
        typeOrder: TypeOrder.limite,
        dateExpiration: DateTime.now().add(const Duration(days: 29)),
        transactionType: TransactionType.action,
      ),
      UserTransaction(
        nOrder: 'ORD001240',
        libelle: 'OPCVM Obligataire',
        dateOrder: DateTime.now().subtract(const Duration(days: 7)),
        sens: TransactionSens.achat,
        cours: 980.00,
        qtyRestant: 50,
        qtyExecute: 0,
        statutSys: StatutSys.saisi,
        statutMarche: StatutMarche.expire,
        typeOrder: TypeOrder.limite,
        dateExpiration: DateTime.now().subtract(const Duration(days: 2)),
        transactionType: TransactionType.opcvm,
      ),
    ];

    _filteredTransactions = _allTransactions;
  }

  void _filterTransactions(TransactionType? type) {
    setState(() {
      _selectedType = type;
      if (type == null) {
        _filteredTransactions = _allTransactions;
      } else {
        _filteredTransactions = _allTransactions
            .where((t) => t.transactionType == type)
            .toList();
      }
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadTransactions();
      _filterTransactions(_selectedType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppColors.primary,
      child: Column(
        children: [
          // Filter chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.surfaceDark
                  : AppColors.surfaceLight,
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    label: 'Tous',
                    isSelected: _selectedType == null,
                    onTap: () => _filterTransactions(null),
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'Actions',
                    isSelected: _selectedType == TransactionType.action,
                    onTap: () => _filterTransactions(TransactionType.action),
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'OPCVM',
                    isSelected: _selectedType == TransactionType.opcvm,
                    onTap: () => _filterTransactions(TransactionType.opcvm),
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'OPV',
                    isSelected: _selectedType == TransactionType.opv,
                    onTap: () => _filterTransactions(TransactionType.opv),
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
          ),

          // Transactions list
          Expanded(
            child: _filteredTransactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          size: 64,
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.3)
                              : AppColors.textTertiaryLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune transaction',
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
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TransactionCard(
                          transaction: _filteredTransactions[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDarkMode
                  ? AppColors.cardDark
                  : AppColors.cardLight),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.borderLight),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
