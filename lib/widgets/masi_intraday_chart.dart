import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math' as math;
import '../config/theme.dart';

class MasiIntradayChart extends StatefulWidget {
  const MasiIntradayChart({super.key});

  @override
  State<MasiIntradayChart> createState() => _MasiIntradayChartState();
}

class _MasiIntradayChartState extends State<MasiIntradayChart> {
  late List<ChartData> _chartData;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _initializeChartData();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: AppColors.primary,
      selectionRectBorderWidth: 1,
      selectionRectColor: AppColors.primary.withOpacity(0.1),
    );
  }

  void _initializeChartData() {
    // Generate realistic intraday data for MASI index
    final now = DateTime.now();
    final startTime = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      0,
    ); // Market opens at 9:00 AM

    _chartData = [];
    double baseValue = 13417.33; // Starting value
    double currentValue = baseValue;
    final random = math.Random(42); // Seed for consistent results

    // Generate data points every 2 minutes from 9:00 AM to 3:30 PM (6.5 hours = 195 points)
    for (int i = 0; i < 195; i++) {
      final time = startTime.add(Duration(minutes: i * 2));

      // Create realistic market patterns
      double trend = 0;

      // Morning volatility (9:00-10:30) - higher activity
      if (i < 45) {
        trend = (random.nextDouble() - 0.48) * 8.0;
      }
      // Mid-morning consolidation (10:30-12:00)
      else if (i < 90) {
        trend = (random.nextDouble() - 0.5) * 3.0;
      }
      // Lunch period (12:00-14:00) - lower activity
      else if (i < 150) {
        trend = (random.nextDouble() - 0.5) * 2.0;
      }
      // Afternoon session (14:00-15:30) - increased activity
      else {
        trend = (random.nextDouble() - 0.52) * 5.0;
      }

      // Add momentum - make price movements smoother
      currentValue += trend * 0.4;

      // Add mean reversion to keep price from drifting too far
      double meanReversion = (baseValue - currentValue) * 0.02;
      currentValue += meanReversion;

      // Add small random noise for realism
      currentValue += (random.nextDouble() - 0.5) * 1.5;

      // Ensure value stays within realistic bounds (±1% from base)
      currentValue = currentValue.clamp(baseValue * 0.99, baseValue * 1.01);

      _chartData.add(ChartData(time, currentValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: 340,
      child: Column(
        children: [
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            backgroundColor: Colors.transparent,
            zoomPanBehavior: _zoomPanBehavior,

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
              dateFormat: intl.DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              interval: 1,
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
              opposedPosition: false,
            ),

            // Tooltip
            tooltipBehavior: TooltipBehavior(
              enable: true,
              color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
              textStyle: TextStyle(
                color:
                    isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              borderColor: AppColors.primary,
              borderWidth: 1,
              format: 'point.x : point.y',
            ),

            // Trackball for better interaction
            trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              lineType: TrackballLineType.vertical,
              lineColor: AppColors.primary.withOpacity(0.5),
              lineWidth: 1,
              tooltipSettings: InteractiveTooltip(
                enable: true,
                color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
                textStyle: TextStyle(
                  color:
                      isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                borderColor: AppColors.primary,
                borderWidth: 1,
              ),
            ),

            // Series
            series: <CartesianSeries<ChartData, DateTime>>[
              // Spline Area series for smooth curved gradient fill
              SplineAreaSeries<ChartData, DateTime>(
                dataSource: _chartData,
                xValueMapper: (ChartData data, _) => data.time,
                yValueMapper: (ChartData data, _) => data.value,
                name: 'MASI',
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFC107).withOpacity(0.3),
                    Color(0xFFFFC107).withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderColor: Color(0xFFFFC107),
                borderWidth: 2,
                splineType: SplineType.natural,
                cardinalSplineTension: 0.5,
              ),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MASI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 30,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.value);
  final DateTime time;
  final double value;
}
