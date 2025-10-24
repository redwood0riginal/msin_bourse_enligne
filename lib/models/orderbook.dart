class MarketOrderBook {
  final String objectType = 'MarketOrderBook';
  final String? secId;
  final String? marketPlace;
  final String? symbol;
  final String? side;
  final double? quantity;
  final double? price;
  final int? orderCount;
  final DateTime? dateOrder;
  final String? orderMarketId;
  final String? orderType;
  final bool isOwnOrder;
  final bool delete;
  final bool deleteAll;

  MarketOrderBook({
    this.secId,
    this.marketPlace,
    this.symbol,
    this.side,
    this.quantity,
    this.price,
    this.orderCount,
    this.dateOrder,
    this.orderMarketId,
    this.orderType,
    this.isOwnOrder = false,
    this.delete = false,
    this.deleteAll = false,
  });

  factory MarketOrderBook.fromJson(Map<String, dynamic> json) {
    return MarketOrderBook(
      secId: json['secId'],
      marketPlace: json['marketPlace'],
      symbol: json['symbol'],
      side: json['side'],
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      orderCount: json['orderCount'] != null ? json['orderCount'] as int : null,
      dateOrder: json['dateOrder'] != null
          ? DateTime.parse(json['dateOrder'])
          : null,
      orderMarketId: json['orderMarketId'],
      orderType: json['orderType'],
      isOwnOrder: json['isOwnOrder'] ?? false,
      delete: json['delete'] ?? false,
      deleteAll: json['deleteAll'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'secId': secId,
      'marketPlace': marketPlace,
      'symbol': symbol,
      'side': side,
      'quantity': quantity,
      'price': price,
      'orderCount': orderCount,
      'dateOrder': dateOrder?.toIso8601String(),
      'orderMarketId': orderMarketId,
      'orderType': orderType,
      'isOwnOrder': isOwnOrder,
      'delete': delete,
      'deleteAll': deleteAll,
    };
  }

  MarketOrderBook copyWith({
    String? secId,
    String? marketPlace,
    String? symbol,
    String? side,
    double? quantity,
    double? price,
    int? orderCount,
    DateTime? dateOrder,
    String? orderMarketId,
    String? orderType,
    bool? isOwnOrder,
    bool? delete,
    bool? deleteAll,
  }) {
    return MarketOrderBook(
      secId: secId ?? this.secId,
      marketPlace: marketPlace ?? this.marketPlace,
      symbol: symbol ?? this.symbol,
      side: side ?? this.side,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      orderCount: orderCount ?? this.orderCount,
      dateOrder: dateOrder ?? this.dateOrder,
      orderMarketId: orderMarketId ?? this.orderMarketId,
      orderType: orderType ?? this.orderType,
      isOwnOrder: isOwnOrder ?? this.isOwnOrder,
      delete: delete ?? this.delete,
      deleteAll: deleteAll ?? this.deleteAll,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketOrderBook && other.orderMarketId == orderMarketId;
  }

  @override
  int get hashCode => orderMarketId.hashCode;

  @override
  String toString() =>
      'MarketOrderBook[orderMarketId=$orderMarketId, symbol=$symbol]';
}
