import 'package:flutter/material.dart';
import 'package:msin_bourse_enligne/screens/trading/order_screen.dart';
import '../../models/market_instrument.dart';
import '../../models/market_summary.dart';
import '../../models/orderbook.dart';
import '../../models/transaction.dart';
import '../../config/theme.dart';
import '../../widgets/charts/stock_price_chart.dart';

class StockDetailScreen extends StatefulWidget {
  final String symbol;
  final MarketInstrument? instrument;
  final MarketSummary? summary;

  const StockDetailScreen({
    super.key,
    required this.symbol,
    this.instrument,
    this.summary,
  });

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = '1J';

  // Sample data - in real app, fetch from API
  late List<MarketOrderBook> _buyOrders;
  late List<MarketOrderBook> _sellOrders;
  late List<MarketTransaction> _transactions;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeSampleData();
  }

  void _initializeSampleData() {
    // Sample buy orders
    _buyOrders = [
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'BUY',
        quantity: 80,
        price: 22.95,
        orderCount: 3,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'BUY',
        quantity: 30,
        price: 21.00,
        orderCount: 2,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'BUY',
        quantity: 50,
        price: 20.95,
        orderCount: 1,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'BUY',
        quantity: 120,
        price: 20.50,
        orderCount: 5,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'BUY',
        quantity: 90,
        price: 20.00,
        orderCount: 4,
      ),
    ];

    // Sample sell orders
    _sellOrders = [
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'SELL',
        quantity: 80,
        price: 22.95,
        orderCount: 2,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'SELL',
        quantity: 30,
        price: 22.00,
        orderCount: 1,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'SELL',
        quantity: 2,
        price: 30.95,
        orderCount: 1,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'SELL',
        quantity: 45,
        price: 31.50,
        orderCount: 3,
      ),
      MarketOrderBook(
        secId: widget.symbol,
        symbol: widget.symbol,
        side: 'SELL',
        quantity: 60,
        price: 32.00,
        orderCount: 2,
      ),
    ];

    // Sample transactions
    _transactions = [
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 5)),
        price: 601.00,
        quantity: 200,
      ),
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 10)),
        price: 601.20,
        quantity: 50,
      ),
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 15)),
        price: 601.20,
        quantity: 50,
      ),
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 20)),
        price: 601.20,
        quantity: 50,
      ),
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 25)),
        price: 601.20,
        quantity: 40,
      ),
      MarketTransaction(
        secId: widget.symbol,
        symbol: widget.symbol,
        dateTrans: DateTime.now().subtract(const Duration(minutes: 30)),
        price: 602.00,
        quantity: 50,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final price = widget.summary?.price ?? 601.00;
    final variation = widget.summary?.variation ?? 1.00;
    final isPositive = variation >= 0;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.surfaceDark : Colors.white,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              widget.symbol,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                if (widget.summary != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OrderScreen(
                            instrument: widget.summary!,
                            initialIsBuy: true,
                          ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Acheter', style: TextStyle(fontSize: 13)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {
                if (widget.summary != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OrderScreen(
                            instrument: widget.summary!,
                            initialIsBuy: false,
                          ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Vendre', style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stock header with price and variation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.surfaceDark : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.instrument?.name ??
                      widget.summary?.name ??
                      widget.symbol,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${price.toStringAsFixed(2)} MAD',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isPositive
                                ? AppColors.success.withOpacity(0.1)
                                : AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 14,
                            color:
                                isPositive
                                    ? AppColors.success
                                    : AppColors.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${isPositive ? '+' : ''}${variation.toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color:
                                  isPositive
                                      ? AppColors.success
                                      : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.surfaceDark : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor:
                  isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Cotation'),
                Tab(text: "Carnet d'ordres"),
                Tab(text: 'Transactions'),
              ],
            ),
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCotationTab(isDarkMode),
                _buildOrderbookTab(isDarkMode),
                _buildTransactionsTab(isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCotationTab(bool isDarkMode) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Chart period selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.surfaceDark : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPeriodButton('1J', isDarkMode),
                  const SizedBox(width: 8),
                  _buildPeriodButton('5J', isDarkMode),
                  const SizedBox(width: 8),
                  _buildPeriodButton('1M', isDarkMode),
                  const SizedBox(width: 8),
                  _buildPeriodButton('3M', isDarkMode),
                  const SizedBox(width: 8),
                  _buildPeriodButton('6M', isDarkMode),
                  const SizedBox(width: 8),
                  _buildPeriodButton('1Y', isDarkMode),
                ],
              ),
            ),
          ),

          // Price chart
          StockPriceChart(
            symbol: widget.symbol,
            summary: widget.summary,
            period: _selectedPeriod,
          ),

          // Instrument information - Enhanced UI
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Informations cotation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                          isDarkMode
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                    ),
                  ),
                ),

                // Grid of info cards
                _buildInfoGrid(isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookTab(bool isDarkMode) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Orderbook header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Qté',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Vente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Achat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Qté',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Orders',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Visual bar showing buy/sell ratio
          _buildOrderBookVisualBar(isDarkMode),

          const SizedBox(height: 16),

          // Orderbook rows
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final sellOrder =
                  index < _sellOrders.length ? _sellOrders[index] : null;
              final buyOrder =
                  index < _buyOrders.length ? _buyOrders[index] : null;

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                          isDarkMode
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        sellOrder?.orderCount?.toString() ?? '--',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        sellOrder?.quantity?.toStringAsFixed(0) ?? '--',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        sellOrder?.price?.toStringAsFixed(2) ?? '--',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        buyOrder?.price?.toStringAsFixed(2) ?? '--',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        buyOrder?.quantity?.toStringAsFixed(0) ?? '--',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        buyOrder?.orderCount?.toString() ?? '--',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBookVisualBar(bool isDarkMode) {
    // Calculate total quantities
    final totalSellQty = _sellOrders.fold<double>(
      0,
      (sum, order) => sum + (order.quantity ?? 0),
    );
    final totalBuyQty = _buyOrders.fold<double>(
      0,
      (sum, order) => sum + (order.quantity ?? 0),
    );
    final totalQty = totalSellQty + totalBuyQty;

    // Calculate percentages
    final sellPercentage = totalQty > 0 ? (totalSellQty / totalQty) : 0.5;
    final buyPercentage = totalQty > 0 ? (totalBuyQty / totalQty) : 0.5;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Bar visualization
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  // Sell side (red)
                  Expanded(
                    flex: (sellPercentage * 100).toInt(),
                    child: Container(
                      color: AppColors.error,
                    ),
                  ),
                  // Buy side (green)
                  Expanded(
                    flex: (buyPercentage * 100).toInt(),
                    child: Container(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Vente: ${totalSellQty.toStringAsFixed(0)} (${(sellPercentage * 100).toStringAsFixed(1)}%)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Achat: ${totalBuyQty.toStringAsFixed(0)} (${(buyPercentage * 100).toStringAsFixed(1)}%)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab(bool isDarkMode) {
    return Column(
      children: [
        // Transactions header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: Border(
              bottom: BorderSide(
                color:
                    isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Heure',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Prix',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Quantité',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Transactions list
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final transaction = _transactions[index];
              final time = transaction.dateTrans;
              final timeStr =
                  time != null
                      ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}'
                      : '--';

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                          isDarkMode
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${transaction.price?.toStringAsFixed(2) ?? '--'} MAD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        transaction.quantity?.toStringAsFixed(0) ?? '--',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isDarkMode
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String label, bool isDarkMode) {
    final isSelected = _selectedPeriod == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary
                  : (isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03)),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected
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
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color:
                isSelected
                    ? Colors.white
                    : (isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoGrid(bool isDarkMode) {
    return Column(
      children: [
        // Key Metrics Section with accent
        _buildMetricsSection(
          isDarkMode,
          [
            {
              'label': 'Dernier cours',
              'value':
                  '${widget.summary?.price?.toStringAsFixed(2) ?? '135.00'}',
              'unit': 'MAD',
              'highlight': true
            },
            {
              'label': 'Variation',
              'value': '${widget.summary?.variation?.toStringAsFixed(2) ?? '0.00'}',
              'unit': '%',
              'highlight': true,
              'isVariation': true
            },
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Price Range Section
        _buildSectionTitle('Fourchette de prix', isDarkMode),
        const SizedBox(height: 12),
        _buildInfoTable(
          isDarkMode,
          [
            {
              'label': 'Ouverture',
              'value':
                  '${widget.summary?.openingPrice?.toStringAsFixed(2) ?? '135.00'} MAD'
            },
            {
              'label': 'Clôture veille',
              'value':
                  '${widget.summary?.lastClosingPrice?.toStringAsFixed(2) ?? '135.00'} MAD'
            },
            {
              'label': 'Plus haut',
              'value':
                  '${widget.summary?.higherPrice?.toStringAsFixed(2) ?? '135.00'} MAD'
            },
            {
              'label': 'Plus bas',
              'value':
                  '${widget.summary?.lowerPrice?.toStringAsFixed(2) ?? '139.00'} MAD'
            },
          ],
        ),

        const SizedBox(height: 24),

        // Trading Activity Section
        _buildSectionTitle('Activité de trading', isDarkMode),
        const SizedBox(height: 12),
        _buildInfoTable(
          isDarkMode,
          [
            {
              'label': 'Volume',
              'value': widget.summary?.volume?.toStringAsFixed(0) ?? '131.00'
            },
            {
              'label': 'Quantité',
              'value': widget.summary?.quantity?.toStringAsFixed(0) ?? '134.63'
            },
            {
              'label': 'Valeur',
              'value': widget.summary?.tov != null
                  ? '${(widget.summary!.tov! / 1000).toStringAsFixed(2)} K MAD'
                  : '19.00 K MAD'
            },
          ],
        ),

        const SizedBox(height: 24),

        // Market Info Section
        _buildSectionTitle('Informations marché', isDarkMode),
        const SizedBox(height: 12),
        _buildInfoTable(
          isDarkMode,
          [
            {'label': 'ISIN', 'value': widget.summary?.secId ?? 'MA0000011512'},
            {
              'label': 'Capitalisation',
              'value': widget.summary?.tov != null
                  ? '${(widget.summary!.tov! / 1000000).toStringAsFixed(2)} M MAD'
                  : '54,344,419,290.00 MAD'
            },
            {
              'label': 'Statut',
              'value': widget.summary?.openCloseIndicator ?? 'Regular Trading'
            },
            {
              'label': 'Séance',
              'value': widget.summary?.marketPlace ?? 'Continu'
            },
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsSection(
      bool isDarkMode, List<Map<String, dynamic>> metrics) {
    final metricWidgets = <Widget>[];
    
    for (int i = 0; i < metrics.length; i++) {
      final metric = metrics[i];
      final isVariation = metric['isVariation'] == true;
      final variation = widget.summary?.variation ?? 0.0;
      final isPositive = variation >= 0;
      
      metricWidgets.add(
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isVariation
                    ? (isPositive
                        ? [
                            AppColors.success.withOpacity(0.1),
                            AppColors.success.withOpacity(0.05),
                          ]
                        : [
                            AppColors.error.withOpacity(0.1),
                            AppColors.error.withOpacity(0.05),
                          ])
                    : [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric['label'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiaryLight,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      metric['value'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: isVariation
                            ? (isPositive ? AppColors.success : AppColors.error)
                            : AppColors.primary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        metric['unit'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      
      // Add spacing between metrics
      if (i < metrics.length - 1) {
        metricWidgets.add(const SizedBox(width: 12));
      }
    }
    
    return Row(children: metricWidgets);
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTable(bool isDarkMode, List<Map<String, String>> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      item['label']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: Text(
                      item['value']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                height: 1,
                thickness: 1,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isDarkMode, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color:
                  isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color:
                  isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
