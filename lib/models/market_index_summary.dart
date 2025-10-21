class MarketIndexSummary {
  final String objectType = 'MarketIndexSummary';
  final String? symbol;
  final double? price;
  final double? closingPrice;
  final double? openingPrice;
  final double? lastClosingPrice;
  final double? lowerPrice;
  final double? higherPrice;
  final double? variation;
  final DateTime? datePrice;

  MarketIndexSummary({
    this.symbol,
    this.price,
    this.closingPrice,
    this.openingPrice,
    this.lastClosingPrice,
    this.lowerPrice,
    this.higherPrice,
    this.variation,
    this.datePrice,
  });

  factory MarketIndexSummary.fromJson(Map<String, dynamic> json) {
    return MarketIndexSummary(
      symbol: json['symbol'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      closingPrice: json['closingPrice'] != null
          ? (json['closingPrice'] as num).toDouble()
          : null,
      openingPrice: json['openingPrice'] != null
          ? (json['openingPrice'] as num).toDouble()
          : null,
      lastClosingPrice: json['lastClosingPrice'] != null
          ? (json['lastClosingPrice'] as num).toDouble()
          : null,
      lowerPrice: json['lowerPrice'] != null
          ? (json['lowerPrice'] as num).toDouble()
          : null,
      higherPrice: json['higherPrice'] != null
          ? (json['higherPrice'] as num).toDouble()
          : null,
      variation: json['variation'] != null
          ? (json['variation'] as num).toDouble()
          : null,
      datePrice: json['datePrice'] != null
          ? DateTime.parse(json['datePrice'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'symbol': symbol,
      'price': price,
      'closingPrice': closingPrice,
      'openingPrice': openingPrice,
      'lastClosingPrice': lastClosingPrice,
      'lowerPrice': lowerPrice,
      'higherPrice': higherPrice,
      'variation': variation,
      'datePrice': datePrice?.toIso8601String(),
    };
  }

  MarketIndexSummary copyWith({
    String? symbol,
    double? price,
    double? closingPrice,
    double? openingPrice,
    double? lastClosingPrice,
    double? lowerPrice,
    double? higherPrice,
    double? variation,
    DateTime? datePrice,
  }) {
    return MarketIndexSummary(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      closingPrice: closingPrice ?? this.closingPrice,
      openingPrice: openingPrice ?? this.openingPrice,
      lastClosingPrice: lastClosingPrice ?? this.lastClosingPrice,
      lowerPrice: lowerPrice ?? this.lowerPrice,
      higherPrice: higherPrice ?? this.higherPrice,
      variation: variation ?? this.variation,
      datePrice: datePrice ?? this.datePrice,
    );
  }

  bool get isPositive => (variation ?? 0) >= 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketIndexSummary && other.symbol == symbol;
  }

  @override
  int get hashCode => symbol.hashCode;

  @override
  String toString() => 'MarketIndexSummary[symbol=$symbol]';
}
