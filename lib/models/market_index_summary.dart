class MarketIndexSummary {
  final String name;
  final double value;
  final double change;
  final double changePercent;
  final String lastUpdate;

  MarketIndexSummary({
    required this.name,
    required this.value,
    required this.change,
    required this.changePercent,
    required this.lastUpdate,
  });

  factory MarketIndexSummary.fromJson(Map<String, dynamic> json) {
    return MarketIndexSummary(
      name: json['name'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
      change: (json['change'] ?? 0).toDouble(),
      changePercent: (json['changePercent'] ?? 0).toDouble(),
      lastUpdate: json['lastUpdate'] ?? '',
    );
  }

  bool get isPositive => change >= 0;
}
