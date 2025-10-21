class Order {
  final int? id;
  final int sign;
  final double? price;
  final double? stopPrice;
  final double? displayedQuantity;
  final double? quantity;
  final double? orderAmount;
  final DateTime? dateOrder;
  final DateTime? dateExpiry;
  final DateTime? timeOrder;
  final DateTime? timeExpiry;
  final DateTime? dateEntry;
  final double? execQty;
  final double? execAvgPrice;
  final String? expiryTypeId;
  final String? statId;
  final String? orderTypeId;
  final int? brokerId;
  final int? cashAccountId;
  final int? entityId;
  final int? portfId;
  final int? subPortfId;
  final int? secAccountId;
  final int? secId;
  final int? userId;
  final String? symbol;
  final String? subRedTypeId;
  final String? externalRef;
  final String? classId;
  final String? accountType;

  Order({
    this.id,
    this.sign = 1,
    this.price,
    this.stopPrice,
    this.displayedQuantity,
    this.quantity,
    this.orderAmount,
    this.dateOrder,
    this.dateExpiry,
    this.timeOrder,
    this.timeExpiry,
    this.dateEntry,
    this.execQty,
    this.execAvgPrice,
    this.expiryTypeId,
    this.statId,
    this.orderTypeId,
    this.brokerId,
    this.cashAccountId,
    this.entityId,
    this.portfId,
    this.subPortfId,
    this.secAccountId,
    this.secId,
    this.userId,
    this.symbol,
    this.subRedTypeId,
    this.externalRef,
    this.classId,
    this.accountType,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      sign: json['sign'] ?? 1,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      stopPrice: json['stopPrice'] != null
          ? (json['stopPrice'] as num).toDouble()
          : null,
      displayedQuantity: json['displayedQuantity'] != null
          ? (json['displayedQuantity'] as num).toDouble()
          : null,
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      orderAmount: json['orderAmount'] != null
          ? (json['orderAmount'] as num).toDouble()
          : null,
      dateOrder: json['dateOrder'] != null
          ? DateTime.parse(json['dateOrder'])
          : null,
      dateExpiry: json['dateExpiry'] != null
          ? DateTime.parse(json['dateExpiry'])
          : null,
      timeOrder: json['timeOrder'] != null
          ? DateTime.parse(json['timeOrder'])
          : null,
      timeExpiry: json['timeExpiry'] != null
          ? DateTime.parse(json['timeExpiry'])
          : null,
      dateEntry: json['dateEntry'] != null
          ? DateTime.parse(json['dateEntry'])
          : null,
      execQty: json['execQty'] != null
          ? (json['execQty'] as num).toDouble()
          : null,
      execAvgPrice: json['execAvgPrice'] != null
          ? (json['execAvgPrice'] as num).toDouble()
          : null,
      expiryTypeId: json['expiryTypeId'],
      statId: json['statId'],
      orderTypeId: json['orderTypeId'],
      brokerId: json['brokerId'],
      cashAccountId: json['cashAccountId'],
      entityId: json['entityId'],
      portfId: json['portfId'],
      subPortfId: json['subPortfId'],
      secAccountId: json['secAccountId'],
      secId: json['secId'],
      userId: json['userId'],
      symbol: json['symbol'],
      subRedTypeId: json['subRedTypeId'],
      externalRef: json['externalRef'],
      classId: json['classId'],
      accountType: json['accountType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sign': sign,
      'price': price,
      'stopPrice': stopPrice,
      'displayedQuantity': displayedQuantity,
      'quantity': quantity,
      'orderAmount': orderAmount,
      'dateOrder': dateOrder?.toIso8601String(),
      'dateExpiry': dateExpiry?.toIso8601String(),
      'timeOrder': timeOrder?.toIso8601String(),
      'timeExpiry': timeExpiry?.toIso8601String(),
      'dateEntry': dateEntry?.toIso8601String(),
      'execQty': execQty,
      'execAvgPrice': execAvgPrice,
      'expiryTypeId': expiryTypeId,
      'statId': statId,
      'orderTypeId': orderTypeId,
      'brokerId': brokerId,
      'cashAccountId': cashAccountId,
      'entityId': entityId,
      'portfId': portfId,
      'subPortfId': subPortfId,
      'secAccountId': secAccountId,
      'secId': secId,
      'userId': userId,
      'symbol': symbol,
      'subRedTypeId': subRedTypeId,
      'externalRef': externalRef,
      'classId': classId,
      'accountType': accountType,
    };
  }

  Order copyWith({
    int? id,
    int? sign,
    double? price,
    double? stopPrice,
    double? displayedQuantity,
    double? quantity,
    double? orderAmount,
    DateTime? dateOrder,
    DateTime? dateExpiry,
    DateTime? timeOrder,
    DateTime? timeExpiry,
    DateTime? dateEntry,
    double? execQty,
    double? execAvgPrice,
    String? expiryTypeId,
    String? statId,
    String? orderTypeId,
    int? brokerId,
    int? cashAccountId,
    int? entityId,
    int? portfId,
    int? subPortfId,
    int? secAccountId,
    int? secId,
    int? userId,
    String? symbol,
    String? subRedTypeId,
    String? externalRef,
    String? classId,
    String? accountType,
  }) {
    return Order(
      id: id ?? this.id,
      sign: sign ?? this.sign,
      price: price ?? this.price,
      stopPrice: stopPrice ?? this.stopPrice,
      displayedQuantity: displayedQuantity ?? this.displayedQuantity,
      quantity: quantity ?? this.quantity,
      orderAmount: orderAmount ?? this.orderAmount,
      dateOrder: dateOrder ?? this.dateOrder,
      dateExpiry: dateExpiry ?? this.dateExpiry,
      timeOrder: timeOrder ?? this.timeOrder,
      timeExpiry: timeExpiry ?? this.timeExpiry,
      dateEntry: dateEntry ?? this.dateEntry,
      execQty: execQty ?? this.execQty,
      execAvgPrice: execAvgPrice ?? this.execAvgPrice,
      expiryTypeId: expiryTypeId ?? this.expiryTypeId,
      statId: statId ?? this.statId,
      orderTypeId: orderTypeId ?? this.orderTypeId,
      brokerId: brokerId ?? this.brokerId,
      cashAccountId: cashAccountId ?? this.cashAccountId,
      entityId: entityId ?? this.entityId,
      portfId: portfId ?? this.portfId,
      subPortfId: subPortfId ?? this.subPortfId,
      secAccountId: secAccountId ?? this.secAccountId,
      secId: secId ?? this.secId,
      userId: userId ?? this.userId,
      symbol: symbol ?? this.symbol,
      subRedTypeId: subRedTypeId ?? this.subRedTypeId,
      externalRef: externalRef ?? this.externalRef,
      classId: classId ?? this.classId,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Order[id=$id, symbol=$symbol]';
}
