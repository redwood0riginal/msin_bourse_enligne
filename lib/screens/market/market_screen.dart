import 'package:flutter/material.dart';
import '../../models/market_summary.dart';
import '../../utils/formatters.dart';
import '../../config/theme.dart';
import 'stock_details_screen.dart';
import '../trading/order_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'Tous';
  String _selectedSort = 'Symbole';
  bool _isLoading = false;
  List<MarketSummary> _instruments = [];

  final List<String> _filters = ['Tous', 'Actions', 'Droits', 'Obligations'];
  final List<String> _sortOptions = [
    'Symbole',
    'Prix ↑',
    'Prix ↓',
    'Variation ↑',
    'Variation ↓',
    'Volume ↑',
    'Volume ↓',
  ];

  @override
  void initState() {
    super.initState();
    _loadInstruments();
  }

  void _loadInstruments() {
    _instruments = [
      MarketSummary(
        secId: 'ATW',
        symbol: 'ATW',
        name: 'Attijariwafa Bank',
        marketPlace: 'CSE',
        price: 542.50,
        variation: 12.50,
        lastClosingPrice: 530.00,
        openingPrice: 535.00,
        higherPrice: 545.00,
        lowerPrice: 530.00,
        volume: 125000,
        tov: 67812500,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'IAM',
        symbol: 'IAM',
        name: 'Maroc Telecom',
        marketPlace: 'CSE',
        price: 128.90,
        variation: 3.20,
        lastClosingPrice: 125.70,
        openingPrice: 126.50,
        higherPrice: 129.50,
        lowerPrice: 125.50,
        volume: 98000,
        tov: 12632200,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'BCP',
        symbol: 'BCP',
        name: 'Banque Centrale Populaire',
        marketPlace: 'CSE',
        price: 285.00,
        variation: 5.80,
        lastClosingPrice: 279.20,
        openingPrice: 280.00,
        higherPrice: 286.00,
        lowerPrice: 278.00,
        volume: 76000,
        tov: 21660000,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'LAB',
        symbol: 'LAB',
        name: 'Label Vie',
        marketPlace: 'CSE',
        price: 3850.00,
        variation: 65.00,
        lastClosingPrice: 3785.00,
        openingPrice: 3800.00,
        higherPrice: 3870.00,
        lowerPrice: 3780.00,
        volume: 45000,
        tov: 173250000,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'CIH',
        symbol: 'CIH',
        name: 'CIH Bank',
        marketPlace: 'CSE',
        price: 315.50,
        variation: 4.50,
        lastClosingPrice: 311.00,
        openingPrice: 312.00,
        higherPrice: 317.00,
        lowerPrice: 310.00,
        volume: 52000,
        tov: 16406000,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'MNG',
        symbol: 'MNG',
        name: 'Managem',
        marketPlace: 'CSE',
        price: 1245.00,
        variation: -28.50,
        lastClosingPrice: 1273.50,
        openingPrice: 1270.00,
        higherPrice: 1275.00,
        lowerPrice: 1240.00,
        volume: 34000,
        tov: 42330000,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'SID',
        symbol: 'SID',
        name: 'Sidérurgie',
        marketPlace: 'CSE',
        price: 425.00,
        variation: -9.20,
        lastClosingPrice: 434.20,
        openingPrice: 432.00,
        higherPrice: 435.00,
        lowerPrice: 423.00,
        volume: 28000,
        tov: 11900000,
        dateUpdate: DateTime.now(),
      ),
      MarketSummary(
        secId: 'ADH',
        symbol: 'ADH',
        name: 'Douja Prom Addoha',
        marketPlace: 'CSE',
        price: 18.50,
        variation: -0.35,
        lastClosingPrice: 18.85,
        openingPrice: 18.80,
        higherPrice: 18.90,
        lowerPrice: 18.40,
        volume: 156000,
        tov: 2886000,
        dateUpdate: DateTime.now(),
      ),
    ];
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    _loadInstruments();

    setState(() {
      _isLoading = false;
    });
  }

  List<MarketSummary> get _filteredInstruments {
    var filtered =
        _instruments.where((instrument) {
          final matchesSearch =
              _searchQuery.isEmpty ||
              (instrument.symbol?.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ??
                  false) ||
              (instrument.name?.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ??
                  false);

          final matchesFilter =
              _selectedFilter == 'Tous' || (_selectedFilter == 'Actions');

          return matchesSearch && matchesFilter;
        }).toList();

    // Apply sorting
    switch (_selectedSort) {
      case 'Prix ↑':
        filtered.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case 'Prix ↓':
        filtered.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'Variation ↑':
        filtered.sort((a, b) => (a.variation ?? 0).compareTo(b.variation ?? 0));
        break;
      case 'Variation ↓':
        filtered.sort((a, b) => (b.variation ?? 0).compareTo(a.variation ?? 0));
        break;
      case 'Volume ↑':
        filtered.sort((a, b) => (a.volume ?? 0).compareTo(b.volume ?? 0));
        break;
      case 'Volume ↓':
        filtered.sort((a, b) => (b.volume ?? 0).compareTo(a.volume ?? 0));
        break;
      case 'Symbole':
      default:
        filtered.sort((a, b) => (a.symbol ?? '').compareTo(b.symbol ?? ''));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppColors.primary,
        child: Column(
          children: [
            // Search and Filter Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isDarkMode
                                ? Colors.white.withOpacity(0.1)
                                : AppColors.borderLight,
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: TextStyle(
                        color:
                            isDarkMode
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Rechercher un titre...',
                        hintStyle: TextStyle(
                          color:
                              isDarkMode
                                  ? AppColors.textTertiaryDark
                                  : AppColors.textTertiaryLight,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color:
                              isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                        ),
                        suffixIcon:
                            _searchQuery.isNotEmpty
                                ? IconButton(
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color:
                                        isDarkMode
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                                : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filter Chips
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final isSelected = _selectedFilter == filter;
                        return FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor:
                              isDarkMode
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.black.withOpacity(0.03),
                          selectedColor: AppColors.primary.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : (isDarkMode
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight),
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                          side: BorderSide(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : (isDarkMode
                                        ? Colors.white.withOpacity(0.1)
                                        : AppColors.borderLight),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Sort and Results Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_filteredInstruments.length} résultat(s)',
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.1)
                                    : AppColors.borderLight,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedSort,
                          isDense: true,
                          underline: const SizedBox(),
                          icon: Icon(
                            Icons.sort_rounded,
                            size: 18,
                            color:
                                isDarkMode
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                          ),
                          style: TextStyle(
                            color:
                                isDarkMode
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          dropdownColor:
                              isDarkMode
                                  ? AppColors.cardDark
                                  : AppColors.cardLight,
                          items:
                              _sortOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedSort = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Instruments List
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredInstruments.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color:
                                  isDarkMode
                                      ? Colors.white.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Aucun résultat',
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredInstruments.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final instrument = _filteredInstruments[index];
                          return _buildInstrumentCard(instrument, isDarkMode);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstrumentCard(MarketSummary instrument, bool isDarkMode) {
    final variation = instrument.variation ?? 0;
    final isPositive = variation >= 0;
    final changePercent = _calculateChangePercent(
      instrument.price,
      instrument.lastClosingPrice,
    );

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Card Content - Tappable
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => StockDetailsScreen(instrument: instrument),
                ),
              );
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Symbol Avatar
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            instrument.symbol?.substring(0, 1) ?? '?',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Symbol and Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              instrument.symbol ?? 'N/A',
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              instrument.name ?? 'N/A',
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? AppColors.textTertiaryDark
                                        : AppColors.textTertiaryLight,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Price and Change
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Formatters.formatNumber(instrument.price ?? 0),
                            style: TextStyle(
                              color:
                                  isDarkMode
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (isPositive
                                      ? AppColors.success
                                      : AppColors.error)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color:
                                      isPositive
                                          ? AppColors.success
                                          : AppColors.error,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  Formatters.formatPercent(changePercent.abs()),
                                  style: TextStyle(
                                    color:
                                        isPositive
                                            ? AppColors.success
                                            : AppColors.error,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Additional Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'Ouv.',
                          Formatters.formatNumber(instrument.openingPrice ?? 0),
                          isDarkMode,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          'Haut',
                          Formatters.formatNumber(instrument.higherPrice ?? 0),
                          isDarkMode,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          'Bas',
                          Formatters.formatNumber(instrument.lowerPrice ?? 0),
                          isDarkMode,
                        ),
                      ),
                      Expanded(
                        child: _buildInfoItem(
                          'CMP',
                          Formatters.formatNumber(
                            instrument.lastClosingPrice ?? 0,
                          ),
                          isDarkMode,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'Volume',
                          Formatters.formatVolume(instrument.volume ?? 0),
                          isDarkMode,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildInfoItem(
                          'Valeur',
                          Formatters.formatCompactCurrency(instrument.tov ?? 0),
                          isDarkMode,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                  instrument: instrument,
                                  initialIsBuy: true,
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          //child: const Icon(Icons.add_circle_outline, size: 18),
                          child: const Text(
                            'Acheter',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),

                      SizedBox(width: 2),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                  instrument: instrument,
                                  initialIsBuy: false,
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          // child: const Icon(
                          //   Icons.remove_circle_outline,
                          //   size: 18,
                          // ),
                          child: const Text(
                            'Vendre',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color:
                isDarkMode
                    ? AppColors.textTertiaryDark
                    : AppColors.textTertiaryLight,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color:
                isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  double _calculateChangePercent(double? current, double? previous) {
    if (current == null || previous == null || previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }
}
