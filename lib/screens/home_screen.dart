import 'package:flutter/material.dart';
import '../models/market_summary.dart';
import '../models/portfolio_summary.dart';
import '../models/market_index_summary.dart';
import '../models/stock_item.dart';
import '../widgets/market_summary_card.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/index_summary_card.dart';
import '../widgets/palmares_widget.dart';
import '../widgets/quick_news_widget.dart';
import '../widgets/masi_intraday_chart.dart';
import '../config/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  // Sample data - Replace with actual API calls
  late MarketSummary _marketSummary;
  late PortfolioSummary _portfolioSummary;
  late MarketIndexSummary _masiIndex;
  late MarketIndexSummary _masi20Index;
  late List<StockItem> _hausses;
  late List<StockItem> _baisses;
  late List<StockItem> _volumes;
  late String _newsHeadline;
  late String _newsTime;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _marketSummary = MarketSummary(
      secId: 'MARKET_GLOBAL',
      marketPlace: 'CSE',
      symbol: 'GLOBAL',
      name: 'Marché Global',
      volume: 2450000000,
      tov: 2450000000,
      variation: 5.2,
      price: 685000000000,
      lastClosingPrice: 675000000000,
      dateUpdate: DateTime.now(),
    );

    _portfolioSummary = PortfolioSummary(
      availableBalance: 125000,
      totalAssets: 485000,
      totalGain: 35000,
      totalGainPercent: 7.8,
    );

    _masiIndex = MarketIndexSummary(
      symbol: 'MASI',
      price: 13542.67,
      variation: 125.34,
      openingPrice: 13417.33,
      closingPrice: 13542.67,
      lastClosingPrice: 13417.33,
      higherPrice: 13560.00,
      lowerPrice: 13400.00,
      datePrice: DateTime.now(),
    );

    _masi20Index = MarketIndexSummary(
      symbol: 'MASI20',
      price: 1098.45,
      variation: 8.76,
      openingPrice: 1089.69,
      closingPrice: 1098.45,
      lastClosingPrice: 1089.69,
      higherPrice: 1100.00,
      lowerPrice: 1085.00,
      datePrice: DateTime.now(),
    );

    _hausses = [
      StockItem(
        symbol: 'ATW',
        name: 'Attijariwafa Bank',
        price: 542.50,
        change: 12.50,
        changePercent: 2.36,
        volume: 125000,
      ),
      StockItem(
        symbol: 'IAM',
        name: 'Maroc Telecom',
        price: 128.90,
        change: 3.20,
        changePercent: 2.55,
        volume: 98000,
      ),
      StockItem(
        symbol: 'BCP',
        name: 'Banque Centrale Populaire',
        price: 285.00,
        change: 5.80,
        changePercent: 2.08,
        volume: 76000,
      ),
      StockItem(
        symbol: 'LAB',
        name: 'Label Vie',
        price: 3850.00,
        change: 65.00,
        changePercent: 1.72,
        volume: 45000,
      ),
      StockItem(
        symbol: 'CIH',
        name: 'CIH Bank',
        price: 315.50,
        change: 4.50,
        changePercent: 1.45,
        volume: 52000,
      ),
    ];

    _baisses = [
      StockItem(
        symbol: 'MNG',
        name: 'Managem',
        price: 1245.00,
        change: -28.50,
        changePercent: -2.24,
        volume: 34000,
      ),
      StockItem(
        symbol: 'SID',
        name: 'Sidérurgie',
        price: 425.00,
        change: -9.20,
        changePercent: -2.12,
        volume: 28000,
      ),
      StockItem(
        symbol: 'ADH',
        name: 'Douja Prom Addoha',
        price: 18.50,
        change: -0.35,
        changePercent: -1.86,
        volume: 156000,
      ),
      StockItem(
        symbol: 'SAH',
        name: 'Saham Assurance',
        price: 1580.00,
        change: -24.00,
        changePercent: -1.50,
        volume: 12000,
      ),
      StockItem(
        symbol: 'ALM',
        name: 'Aluminium du Maroc',
        price: 2150.00,
        change: -28.00,
        changePercent: -1.28,
        volume: 8500,
      ),
    ];

    _volumes = [
      StockItem(
        symbol: 'ATW',
        name: 'Attijariwafa Bank',
        price: 542.50,
        change: 12.50,
        changePercent: 2.36,
        volume: 2500000,
      ),
      StockItem(
        symbol: 'ADH',
        name: 'Douja Prom Addoha',
        price: 18.50,
        change: -0.35,
        changePercent: -1.86,
        volume: 1850000,
      ),
      StockItem(
        symbol: 'BCP',
        name: 'Banque Centrale Populaire',
        price: 285.00,
        change: 5.80,
        changePercent: 2.08,
        volume: 1420000,
      ),
      StockItem(
        symbol: 'IAM',
        name: 'Maroc Telecom',
        price: 128.90,
        change: 3.20,
        changePercent: 2.55,
        volume: 980000,
      ),
      StockItem(
        symbol: 'CIH',
        name: 'CIH Bank',
        price: 315.50,
        change: 4.50,
        changePercent: 1.45,
        volume: 850000,
      ),
    ];

    _newsHeadline =
        'La Bourse de Casablanca clôture en hausse, le MASI gagne 0,93%';
    _newsTime = 'Il y a 2h';
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _refreshData,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        //padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick News
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuickNewsWidget(
                headline: _newsHeadline,
                time: _newsTime,
                onTap: () {
                  // Navigate to news detail or news screen
                },
              ),
            ),
            const SizedBox(height: 8),

            // Market and Portfolio Cards - Horizontal Scroll
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: MarketSummaryCard(summary: _marketSummary),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: PortfolioSummaryCard(summary: _portfolioSummary),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Index Cards Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: IndexSummaryCard(index: _masiIndex)),
                  const SizedBox(width: 16),
                  Expanded(child: IndexSummaryCard(index: _masi20Index)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // MASI Intraday Chart
            const MasiIntradayChart(),
            const SizedBox(height: 8),

            // Palmares Widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PalmaresWidget(
                hausses: _hausses,
                baisses: _baisses,
                volumes: _volumes,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
