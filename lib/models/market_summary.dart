class MarketSummary {
  final double globalVolume;
  final double marketCapitalization;
  final double volumeChange;
  final double capChange;

  MarketSummary({
    required this.globalVolume,
    required this.marketCapitalization,
    required this.volumeChange,
    required this.capChange,
  });

  factory MarketSummary.fromJson(Map<String, dynamic> json) {
    return MarketSummary(
      globalVolume: (json['globalVolume'] ?? 0).toDouble(),
      marketCapitalization: (json['marketCapitalization'] ?? 0).toDouble(),
      volumeChange: (json['volumeChange'] ?? 0).toDouble(),
      capChange: (json['capChange'] ?? 0).toDouble(),
    );
  }
}
