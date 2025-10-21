class MarketInstrument {
  final String objectType = 'MarketInstrument';
  final String? id;
  final String? marketPlace;
  final String? symbol;
  final String? name;
  final String? classId;
  final DateTime? issueDate;
  final DateTime? maturityDate;
  final DateTime? lastTradeTime;
  final String? issuer;
  final String? marketSegment;
  final String? priceType;
  final String? matchType;
  final String? tradingType;
  final String? tradingStatus;
  final String? currency;
  final String? haltReason;
  final String? sessionChangeReason;
  final double? highPx;
  final double? lowPx;
  final double? lastPx;
  final double? cumQty;
  final String? identificationNumber;
  final String? underlying;
  final double? strikePrice;
  final String? optionType;
  final double? coupon;
  final String? corporateAction;
  final String? sector;
  final String? marketType;
  final double? issuedQty;
  final double? contractMultiplier;
  final String? settlementMethod;

  MarketInstrument({
    this.id,
    this.marketPlace,
    this.symbol,
    this.name,
    this.classId,
    this.issueDate,
    this.maturityDate,
    this.lastTradeTime,
    this.issuer,
    this.marketSegment,
    this.priceType,
    this.matchType,
    this.tradingType,
    this.tradingStatus,
    this.currency,
    this.haltReason,
    this.sessionChangeReason,
    this.highPx,
    this.lowPx,
    this.lastPx,
    this.cumQty,
    this.identificationNumber,
    this.underlying,
    this.strikePrice,
    this.optionType,
    this.coupon,
    this.corporateAction,
    this.sector,
    this.marketType,
    this.issuedQty,
    this.contractMultiplier,
    this.settlementMethod,
  });

  factory MarketInstrument.fromJson(Map<String, dynamic> json) {
    return MarketInstrument(
      id: json['id'],
      marketPlace: json['marketPlace'],
      symbol: json['symbol'],
      name: json['name'],
      classId: json['classId'],
      issueDate: json['issueDate'] != null
          ? DateTime.parse(json['issueDate'])
          : null,
      maturityDate: json['maturityDate'] != null
          ? DateTime.parse(json['maturityDate'])
          : null,
      lastTradeTime: json['lastTradeTime'] != null
          ? DateTime.parse(json['lastTradeTime'])
          : null,
      issuer: json['issuer'],
      marketSegment: json['marketSegment'],
      priceType: json['priceType'],
      matchType: json['matchType'],
      tradingType: json['tradingType'],
      tradingStatus: json['tradingStatus'],
      currency: json['currency'],
      haltReason: json['haltReason'],
      sessionChangeReason: json['sessionChangeReason'],
      highPx: json['highPx'] != null ? (json['highPx'] as num).toDouble() : null,
      lowPx: json['lowPx'] != null ? (json['lowPx'] as num).toDouble() : null,
      lastPx: json['lastPx'] != null ? (json['lastPx'] as num).toDouble() : null,
      cumQty: json['cumQty'] != null ? (json['cumQty'] as num).toDouble() : null,
      identificationNumber: json['identificationNumber'],
      underlying: json['underlying'],
      strikePrice: json['strikePrice'] != null
          ? (json['strikePrice'] as num).toDouble()
          : null,
      optionType: json['optionType'],
      coupon: json['coupon'] != null ? (json['coupon'] as num).toDouble() : null,
      corporateAction: json['corporateAction'],
      sector: json['sector'],
      marketType: json['marketType'],
      issuedQty: json['issuedQty'] != null
          ? (json['issuedQty'] as num).toDouble()
          : null,
      contractMultiplier: json['contractMultiplier'] != null
          ? (json['contractMultiplier'] as num).toDouble()
          : null,
      settlementMethod: json['settlementMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'id': id,
      'marketPlace': marketPlace,
      'symbol': symbol,
      'name': name,
      'classId': classId,
      'issueDate': issueDate?.toIso8601String(),
      'maturityDate': maturityDate?.toIso8601String(),
      'lastTradeTime': lastTradeTime?.toIso8601String(),
      'issuer': issuer,
      'marketSegment': marketSegment,
      'priceType': priceType,
      'matchType': matchType,
      'tradingType': tradingType,
      'tradingStatus': tradingStatus,
      'currency': currency,
      'haltReason': haltReason,
      'sessionChangeReason': sessionChangeReason,
      'highPx': highPx,
      'lowPx': lowPx,
      'lastPx': lastPx,
      'cumQty': cumQty,
      'identificationNumber': identificationNumber,
      'underlying': underlying,
      'strikePrice': strikePrice,
      'optionType': optionType,
      'coupon': coupon,
      'corporateAction': corporateAction,
      'sector': sector,
      'marketType': marketType,
      'issuedQty': issuedQty,
      'contractMultiplier': contractMultiplier,
      'settlementMethod': settlementMethod,
    };
  }

  MarketInstrument copyWith({
    String? id,
    String? marketPlace,
    String? symbol,
    String? name,
    String? classId,
    DateTime? issueDate,
    DateTime? maturityDate,
    DateTime? lastTradeTime,
    String? issuer,
    String? marketSegment,
    String? priceType,
    String? matchType,
    String? tradingType,
    String? tradingStatus,
    String? currency,
    String? haltReason,
    String? sessionChangeReason,
    double? highPx,
    double? lowPx,
    double? lastPx,
    double? cumQty,
    String? identificationNumber,
    String? underlying,
    double? strikePrice,
    String? optionType,
    double? coupon,
    String? corporateAction,
    String? sector,
    String? marketType,
    double? issuedQty,
    double? contractMultiplier,
    String? settlementMethod,
  }) {
    return MarketInstrument(
      id: id ?? this.id,
      marketPlace: marketPlace ?? this.marketPlace,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      classId: classId ?? this.classId,
      issueDate: issueDate ?? this.issueDate,
      maturityDate: maturityDate ?? this.maturityDate,
      lastTradeTime: lastTradeTime ?? this.lastTradeTime,
      issuer: issuer ?? this.issuer,
      marketSegment: marketSegment ?? this.marketSegment,
      priceType: priceType ?? this.priceType,
      matchType: matchType ?? this.matchType,
      tradingType: tradingType ?? this.tradingType,
      tradingStatus: tradingStatus ?? this.tradingStatus,
      currency: currency ?? this.currency,
      haltReason: haltReason ?? this.haltReason,
      sessionChangeReason: sessionChangeReason ?? this.sessionChangeReason,
      highPx: highPx ?? this.highPx,
      lowPx: lowPx ?? this.lowPx,
      lastPx: lastPx ?? this.lastPx,
      cumQty: cumQty ?? this.cumQty,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      underlying: underlying ?? this.underlying,
      strikePrice: strikePrice ?? this.strikePrice,
      optionType: optionType ?? this.optionType,
      coupon: coupon ?? this.coupon,
      corporateAction: corporateAction ?? this.corporateAction,
      sector: sector ?? this.sector,
      marketType: marketType ?? this.marketType,
      issuedQty: issuedQty ?? this.issuedQty,
      contractMultiplier: contractMultiplier ?? this.contractMultiplier,
      settlementMethod: settlementMethod ?? this.settlementMethod,
    );
  }

  // Update method similar to Java's update method
  MarketInstrument update(MarketInstrument instr) {
    return MarketInstrument(
      id: id,
      marketPlace: marketPlace,
      symbol: symbol,
      name: instr.name ?? name,
      classId: classId,
      issueDate: instr.issueDate ?? issueDate,
      maturityDate: instr.maturityDate ?? maturityDate,
      lastTradeTime: instr.lastTradeTime ?? lastTradeTime,
      issuer: instr.issuer ?? issuer,
      marketSegment: marketSegment,
      priceType: instr.priceType ?? priceType,
      matchType: instr.matchType ?? matchType,
      tradingType: instr.tradingType ?? tradingType,
      tradingStatus: instr.tradingStatus ?? tradingStatus,
      currency: instr.currency ?? currency,
      haltReason: instr.haltReason ?? haltReason,
      sessionChangeReason: instr.sessionChangeReason ?? sessionChangeReason,
      highPx: instr.highPx ?? highPx,
      lowPx: instr.lowPx ?? lowPx,
      lastPx: instr.lastPx ?? lastPx,
      cumQty: instr.cumQty ?? cumQty,
      identificationNumber: instr.identificationNumber ?? identificationNumber,
      underlying: instr.underlying ?? underlying,
      strikePrice: instr.strikePrice ?? strikePrice,
      optionType: instr.optionType ?? optionType,
      coupon: instr.coupon ?? coupon,
      corporateAction: instr.corporateAction ?? corporateAction,
      sector: instr.sector ?? sector,
      marketType: instr.marketType ?? marketType,
      issuedQty: instr.issuedQty ?? issuedQty,
      contractMultiplier: instr.contractMultiplier ?? contractMultiplier,
      settlementMethod: instr.settlementMethod ?? settlementMethod,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketInstrument && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MarketInstrument[id=$id, symbol=$symbol]';
}
