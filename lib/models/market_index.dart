class MarketIndex {
  final String objectType = 'MarketIndex';
  final String? id;
  final String? name;
  final String? marketPlace;
  final String? indexType;
  final double? price;
  final DateTime? datePrice;

  MarketIndex({
    this.id,
    this.name,
    this.marketPlace,
    this.indexType,
    this.price,
    this.datePrice,
  });

  factory MarketIndex.fromJson(Map<String, dynamic> json) {
    return MarketIndex(
      id: json['id'],
      name: json['name'],
      marketPlace: json['marketPlace'],
      indexType: json['indexType'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      datePrice: json['datePrice'] != null
          ? DateTime.parse(json['datePrice'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'id': id,
      'name': name,
      'marketPlace': marketPlace,
      'indexType': indexType,
      'price': price,
      'datePrice': datePrice?.toIso8601String(),
    };
  }

  MarketIndex copyWith({
    String? id,
    String? name,
    String? marketPlace,
    String? indexType,
    double? price,
    DateTime? datePrice,
  }) {
    return MarketIndex(
      id: id ?? this.id,
      name: name ?? this.name,
      marketPlace: marketPlace ?? this.marketPlace,
      indexType: indexType ?? this.indexType,
      price: price ?? this.price,
      datePrice: datePrice ?? this.datePrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketIndex && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MarketIndex[id=$id]';
}
