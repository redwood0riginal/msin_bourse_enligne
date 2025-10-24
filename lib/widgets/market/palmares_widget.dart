import 'package:flutter/material.dart';
import '../../models/stock_item.dart';
import '../../utils/formatters.dart';
import '../../config/theme.dart';

class PalmaresWidget extends StatefulWidget {
  final List<StockItem> hausses;
  final List<StockItem> baisses;
  final List<StockItem> volumes;

  const PalmaresWidget({
    super.key,
    required this.hausses,
    required this.baisses,
    required this.volumes,
  });

  @override
  State<PalmaresWidget> createState() => _PalmaresWidgetState();
}

class _PalmaresWidgetState extends State<PalmaresWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.leaderboard_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Palmarès',
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelColor: AppColors.primary,
              unselectedLabelColor: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Hausses'),
                Tab(text: 'Baisses'),
                Tab(text: 'Volume'),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStockList(widget.hausses, true),
                _buildStockList(widget.baisses, false),
                _buildVolumeList(widget.volumes),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockList(List<StockItem> stocks, bool isHausse) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
            ),
            const SizedBox(height: 12),
            Text(
              'Aucune donnée disponible',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: stocks.length,
      separatorBuilder: (context, index) => Divider(
        height: 24,
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
      ),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return _buildStockItem(stock, isHausse);
      },
    );
  }

  Widget _buildVolumeList(List<StockItem> stocks) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (stocks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
            ),
            const SizedBox(height: 12),
            Text(
              'Aucune donnée disponible',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: stocks.length,
      separatorBuilder: (context, index) => Divider(
        height: 24,
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
      ),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return _buildVolumeItem(stock);
      },
    );
  }

  Widget _buildStockItem(StockItem stock, bool isHausse) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = isHausse ? AppColors.success : AppColors.error;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              stock.symbol.substring(0, 1),
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.symbol,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                stock.name,
                style: TextStyle(
                  color: isDarkMode
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Formatters.formatNumber(stock.price),
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                Formatters.formatPercent(stock.changePercent),
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVolumeItem(StockItem stock) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isPositive = stock.isPositive;
    final color = isPositive ? AppColors.success : AppColors.error;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              stock.symbol.substring(0, 1),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.symbol,
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                stock.name,
                style: TextStyle(
                  color: isDarkMode
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Formatters.formatVolume(stock.volume),
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                Formatters.formatPercent(stock.changePercent),
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
