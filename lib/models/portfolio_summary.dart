class PortfolioSummary {
  final double availableBalance;
  final double totalAssets;
  final double totalGain;
  final double totalGainPercent;

  PortfolioSummary({
    required this.availableBalance,
    required this.totalAssets,
    required this.totalGain,
    required this.totalGainPercent,
  });

  factory PortfolioSummary.fromJson(Map<String, dynamic> json) {
    return PortfolioSummary(
      availableBalance: (json['availableBalance'] ?? 0).toDouble(),
      totalAssets: (json['totalAssets'] ?? 0).toDouble(),
      totalGain: (json['totalGain'] ?? 0).toDouble(),
      totalGainPercent: (json['totalGainPercent'] ?? 0).toDouble(),
    );
  }

  bool get isPositive => totalGain >= 0;
}
