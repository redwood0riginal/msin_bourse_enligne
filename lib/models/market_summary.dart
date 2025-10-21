class MarketSummary {
  final String objectType = 'MarketSummary';
  final String? secId;
  final String? marketPlace;
  final String? openCloseIndicator;
  final String? symbol;
  final String? name;
  final double? lastClosingPrice;
  final double? top;
  final double? tov;
  final double? closingPrice;
  final double? openingPrice;
  final DateTime? dateTrans;
  final double? price;
  final double? variation;
  final double? higherPrice;
  final double? lowerPrice;
  final double? higherLimit;
  final double? lowerLimit;
  final double? staticHigherLimit;
  final double? staticLowerLimit;
  final double? vwap;
  final double? quantity;
  final double? volume;
  final DateTime? dateUpdate;
  final double? notionalExposer;
  final double? underlyingRefPrice;
  final double? openIntrest;
  final double? theoreticalPrice;
  final double? auctionQty;
  final double? auctionImbalanceQty;
  final double? auctionPrice;
  final String? auctionType;
  final double? priceBandLimitSup;
  final double? priceBandLimitInf;

  MarketSummary({
    this.secId,
    this.marketPlace,
    this.openCloseIndicator,
    this.symbol,
    this.name,
    this.lastClosingPrice,
    this.top,
    this.tov,
    this.closingPrice,
    this.openingPrice,
    this.dateTrans,
    this.price,
    this.variation,
    this.higherPrice,
    this.lowerPrice,
    this.higherLimit,
    this.lowerLimit,
    this.staticHigherLimit,
    this.staticLowerLimit,
    this.vwap,
    this.quantity,
    this.volume,
    this.dateUpdate,
    this.notionalExposer,
    this.underlyingRefPrice,
    this.openIntrest,
    this.theoreticalPrice,
    this.auctionQty,
    this.auctionImbalanceQty,
    this.auctionPrice,
    this.auctionType,
    this.priceBandLimitSup,
    this.priceBandLimitInf,
  });

  String get displayName => name ?? symbol ?? '';

  factory MarketSummary.fromJson(Map<String, dynamic> json) {
    return MarketSummary(
      secId: json['secId'],
      marketPlace: json['marketPlace'],
      openCloseIndicator: json['openCloseIndicator'],
      symbol: json['symbol'],
      name: json['name'],
      lastClosingPrice: json['lastClosingPrice'] != null
          ? (json['lastClosingPrice'] as num).toDouble()
          : null,
      top: json['top'] != null ? (json['top'] as num).toDouble() : null,
      tov: json['tov'] != null ? (json['tov'] as num).toDouble() : null,
      closingPrice: json['closingPrice'] != null
          ? (json['closingPrice'] as num).toDouble()
          : null,
      openingPrice: json['openingPrice'] != null
          ? (json['openingPrice'] as num).toDouble()
          : null,
      dateTrans: json['dateTrans'] != null
          ? DateTime.parse(json['dateTrans'])
          : null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      variation: json['variation'] != null
          ? (json['variation'] as num).toDouble()
          : null,
      higherPrice: json['higherPrice'] != null
          ? (json['higherPrice'] as num).toDouble()
          : null,
      lowerPrice: json['lowerPrice'] != null
          ? (json['lowerPrice'] as num).toDouble()
          : null,
      higherLimit: json['higherLimit'] != null
          ? (json['higherLimit'] as num).toDouble()
          : null,
      lowerLimit: json['lowerLimit'] != null
          ? (json['lowerLimit'] as num).toDouble()
          : null,
      staticHigherLimit: json['staticHigherLimit'] != null
          ? (json['staticHigherLimit'] as num).toDouble()
          : null,
      staticLowerLimit: json['staticLowerLimit'] != null
          ? (json['staticLowerLimit'] as num).toDouble()
          : null,
      vwap: json['vwap'] != null ? (json['vwap'] as num).toDouble() : null,
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      volume:
          json['volume'] != null ? (json['volume'] as num).toDouble() : null,
      dateUpdate: json['dateUpdate'] != null
          ? DateTime.parse(json['dateUpdate'])
          : null,
      notionalExposer: json['notionalExposer'] != null
          ? (json['notionalExposer'] as num).toDouble()
          : null,
      underlyingRefPrice: json['underlyingRefPrice'] != null
          ? (json['underlyingRefPrice'] as num).toDouble()
          : null,
      openIntrest: json['openIntrest'] != null
          ? (json['openIntrest'] as num).toDouble()
          : null,
      theoreticalPrice: json['theoreticalPrice'] != null
          ? (json['theoreticalPrice'] as num).toDouble()
          : null,
      auctionQty: json['auctionQty'] != null
          ? (json['auctionQty'] as num).toDouble()
          : null,
      auctionImbalanceQty: json['auctionImbalanceQty'] != null
          ? (json['auctionImbalanceQty'] as num).toDouble()
          : null,
      auctionPrice: json['auctionPrice'] != null
          ? (json['auctionPrice'] as num).toDouble()
          : null,
      auctionType: json['auctionType'],
      priceBandLimitSup: json['priceBandLimitSup'] != null
          ? (json['priceBandLimitSup'] as num).toDouble()
          : null,
      priceBandLimitInf: json['priceBandLimitInf'] != null
          ? (json['priceBandLimitInf'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'secId': secId,
      'marketPlace': marketPlace,
      'openCloseIndicator': openCloseIndicator,
      'symbol': symbol,
      'name': name,
      'lastClosingPrice': lastClosingPrice,
      'top': top,
      'tov': tov,
      'closingPrice': closingPrice,
      'openingPrice': openingPrice,
      'dateTrans': dateTrans?.toIso8601String(),
      'price': price,
      'variation': variation,
      'higherPrice': higherPrice,
      'lowerPrice': lowerPrice,
      'higherLimit': higherLimit,
      'lowerLimit': lowerLimit,
      'staticHigherLimit': staticHigherLimit,
      'staticLowerLimit': staticLowerLimit,
      'vwap': vwap,
      'quantity': quantity,
      'volume': volume,
      'dateUpdate': dateUpdate?.toIso8601String(),
      'notionalExposer': notionalExposer,
      'underlyingRefPrice': underlyingRefPrice,
      'openIntrest': openIntrest,
      'theoreticalPrice': theoreticalPrice,
      'auctionQty': auctionQty,
      'auctionImbalanceQty': auctionImbalanceQty,
      'auctionPrice': auctionPrice,
      'auctionType': auctionType,
      'priceBandLimitSup': priceBandLimitSup,
      'priceBandLimitInf': priceBandLimitInf,
    };
  }

  // Update method similar to Java's update method
  MarketSummary update(MarketSummary summary) {
    return MarketSummary(
      secId: secId,
      marketPlace: marketPlace,
      openCloseIndicator: openCloseIndicator,
      symbol: symbol,
      name: name,
      lastClosingPrice: summary.lastClosingPrice ?? lastClosingPrice,
      top: summary.top ?? top,
      tov: summary.tov ?? tov,
      closingPrice: summary.closingPrice ?? closingPrice,
      openingPrice: summary.openingPrice ?? openingPrice,
      dateTrans: summary.dateTrans ?? dateTrans,
      price: summary.price ?? price,
      variation: summary.variation ?? variation,
      higherPrice: summary.higherPrice ?? higherPrice,
      lowerPrice: summary.lowerPrice ?? lowerPrice,
      higherLimit: summary.higherLimit ?? higherLimit,
      lowerLimit: summary.lowerLimit ?? lowerLimit,
      staticHigherLimit: summary.staticHigherLimit ?? staticHigherLimit,
      staticLowerLimit: summary.staticLowerLimit ?? staticLowerLimit,
      vwap: summary.vwap ?? vwap,
      quantity: summary.quantity ?? quantity,
      volume: summary.volume ?? volume,
      dateUpdate: summary.dateUpdate ?? dateUpdate,
      notionalExposer: summary.notionalExposer ?? notionalExposer,
      underlyingRefPrice: summary.underlyingRefPrice ?? underlyingRefPrice,
      openIntrest: summary.openIntrest ?? openIntrest,
      theoreticalPrice: summary.theoreticalPrice ?? theoreticalPrice,
      auctionQty: summary.auctionQty ?? auctionQty,
      auctionImbalanceQty: summary.auctionImbalanceQty ?? auctionImbalanceQty,
      auctionPrice: summary.auctionPrice ?? auctionPrice,
      auctionType: summary.auctionType ?? auctionType,
      priceBandLimitSup: summary.priceBandLimitSup ?? priceBandLimitSup,
      priceBandLimitInf: summary.priceBandLimitInf ?? priceBandLimitInf,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketSummary && other.secId == secId;
  }

  @override
  int get hashCode => secId.hashCode;

  @override
  String toString() => 'MarketSummary[secId=$secId, symbol=$symbol]';
}
