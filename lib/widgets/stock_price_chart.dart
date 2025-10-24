import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;
import '../config/theme.dart';
import '../models/market_summary.dart';

class StockPriceChart extends StatefulWidget {
  final String symbol;
  final MarketSummary? summary;
  final String period;

  const StockPriceChart({
    super.key,
    required this.symbol,
    this.summary,
    required this.period,
  });

  @override
  State<StockPriceChart> createState() => _StockPriceChartState();
}

class _StockPriceChartState extends State<StockPriceChart> {
  late List<ChartData> _chartData;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _initializeChartData();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: false,
      enableDoubleTapZooming: false,
      enablePanning: false,
      enableSelectionZooming: false,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineType: TrackballLineType.vertical,
      lineColor: AppColors.primary.withOpacity(0.5),
      lineWidth: 1,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      builder: (BuildContext context, TrackballDetails trackballDetails) {
        return _buildCustomTooltip(trackballDetails);
      },
    );
  }

  @override
  void didUpdateWidget(StockPriceChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      _initializeChartData();
    }
  }

  void _initializeChartData() {
    final now = DateTime.now();
    _chartData = [];
    
    double baseValue = widget.summary?.lastClosingPrice ?? 600.0;
    double currentValue = baseValue;
    final random = math.Random(widget.symbol.hashCode);

    switch (widget.period) {
      case '1J':
        _generateIntradayData(now, baseValue, currentValue, random);
        break;
      case '5J':
        _generateDailyData(now, 5, baseValue, currentValue, random);
        break;
      case '1M':
        _generateDailyData(now, 30, baseValue, currentValue, random);
        break;
      case '3M':
        _generateDailyData(now, 90, baseValue, currentValue, random);
        break;
      case '6M':
        _generateDailyData(now, 180, baseValue, currentValue, random);
        break;
      case '1Y':
        _generateDailyData(now, 365, baseValue, currentValue, random);
        break;
    }
  }

  void _generateIntradayData(DateTime now, double baseValue, double currentValue, math.Random random) {
    final startTime = DateTime(now.year, now.month, now.day, 9, 0);
    
    // Generate data points every 5 minutes from 9:00 AM to 3:30 PM (78 points)
    for (int i = 0; i < 78; i++) {
      final time = startTime.add(Duration(minutes: i * 5));
      
      double trend = 0;
      if (i < 18) {
        trend = (random.nextDouble() - 0.48) * 2.0;
      } else if (i < 36) {
        trend = (random.nextDouble() - 0.5) * 1.0;
      } else if (i < 60) {
        trend = (random.nextDouble() - 0.5) * 0.8;
      } else {
        trend = (random.nextDouble() - 0.52) * 1.5;
      }

      currentValue += trend * 0.4;
      double meanReversion = (baseValue - currentValue) * 0.02;
      currentValue += meanReversion;
      currentValue += (random.nextDouble() - 0.5) * 0.5;
      currentValue = currentValue.clamp(baseValue * 0.98, baseValue * 1.02);

      final high = currentValue + random.nextDouble() * 2;
      final low = currentValue - random.nextDouble() * 2;
      final volume = (50000 + random.nextDouble() * 100000).toDouble();

      _chartData.add(ChartData(
        time,
        currentValue,
        baseValue,
        high,
        low,
        volume,
      ));
    }
  }

  void _generateDailyData(DateTime now, int days, double baseValue, double currentValue, math.Random random) {
    currentValue = baseValue * 0.90; // Start lower for upward trend
    
    for (int i = days; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      
      // Skip weekends
      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
        continue;
      }

      final trend = (random.nextDouble() - 0.48) * 3.0;
      final volatility = random.nextDouble() * 2.0;
      
      final high = currentValue + volatility + (trend > 0 ? trend : 0);
      final low = currentValue - volatility + (trend < 0 ? trend : 0);
      currentValue += trend;
      
      final volume = (50000 + random.nextDouble() * 100000 + (trend.abs() * 10000)).toDouble();

      _chartData.add(ChartData(
        date,
        currentValue,
        baseValue,
        high,
        low,
        volume,
      ));
    }
  }

  Widget _buildCustomTooltip(TrackballDetails trackballDetails) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    if (trackballDetails.groupingModeInfo == null || 
        trackballDetails.groupingModeInfo!.points.isEmpty) {
      return const SizedBox.shrink();
    }

    final point = trackballDetails.groupingModeInfo!.points.first;
    
    // Find the matching chart data by x value
    final xValue = point.x;
    ChartData? chartData;
    
    for (var data in _chartData) {
      if (data.time == xValue) {
        chartData = data;
        break;
      }
    }
    
    if (chartData == null) {
      return const SizedBox.shrink();
    }
    
    final timeFormat = widget.period == '1J' 
        ? intl.DateFormat('HH:mm')
        : intl.DateFormat('dd/MM/yyyy');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'date: ${timeFormat.format(chartData.time)}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          _buildTooltipRow('Cours', '${chartData.value.toStringAsFixed(2)} MAD', isDarkMode),
          _buildTooltipRow('Cours veille', '${chartData.previousClose.toStringAsFixed(2)} MAD', isDarkMode),
          _buildTooltipRow('Cours max', '${chartData.high.toStringAsFixed(2)} MAD', isDarkMode),
          _buildTooltipRow('Cours min', '${chartData.low.toStringAsFixed(2)} MAD', isDarkMode),
          _buildTooltipRow('Volume', chartData.volume.toStringAsFixed(0), isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTooltipRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 10,
              color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final variation = widget.summary?.variation ?? 1.0;
    final isPositive = variation >= 0;
    final chartColor = isPositive ? AppColors.success : AppColors.error;

    return SizedBox(
      height: 320,
      width: double.infinity,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        backgroundColor: Colors.transparent,
        zoomPanBehavior: _zoomPanBehavior,
        trackballBehavior: _trackballBehavior,

        // Primary X-Axis (Time)
        primaryXAxis: DateTimeAxis(
          majorGridLines: MajorGridLines(
            width: 0.5,
            color:
                isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
          ),
          axisLine: AxisLine(
            color:
                isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.borderLight,
          ),
          labelStyle: TextStyle(
            color:
                isDarkMode
                    ? AppColors.textTertiaryDark
                    : AppColors.textTertiaryLight,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          dateFormat: widget.period == '1J' 
              ? intl.DateFormat.Hm()
              : intl.DateFormat.MMMd(),
          intervalType: widget.period == '1J' 
              ? DateTimeIntervalType.hours
              : DateTimeIntervalType.auto,
          interval: widget.period == '1J' ? 1 : null,
        ),

        // Primary Y-Axis (Price)
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 0.5,
            color:
                isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
          ),
          axisLine: AxisLine(
            color:
                isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : AppColors.borderLight,
          ),
          labelStyle: TextStyle(
            color:
                isDarkMode
                    ? AppColors.textTertiaryDark
                    : AppColors.textTertiaryLight,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          numberFormat: intl.NumberFormat('#,##0.00'),
          opposedPosition: true,
        ),

        // Series
        series: <CartesianSeries<ChartData, DateTime>>[
          // Area series with gradient fill
          AreaSeries<ChartData, DateTime>(
            dataSource: _chartData,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.value,
            name: widget.symbol,
            gradient: LinearGradient(
              colors: [
                chartColor.withOpacity(0.3),
                chartColor.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderColor: chartColor,
            borderWidth: 2,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.time,
    this.value,
    this.previousClose,
    this.high,
    this.low,
    this.volume,
  );
  
  final DateTime time;
  final double value;
  final double previousClose;
  final double high;
  final double low;
  final double volume;
}
