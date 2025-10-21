class MarketTransaction {
  final String objectType = 'MarketTransaction';
  final int? id;
  final String? marketPlace;
  final String? secId;
  final String? execId;
  final String? execType;
  final String? side;
  final String? prevExecId;
  final DateTime? dateTrans;
  final String? symbol;
  final double? quantity;
  final double? price;
  final String? sequence;
  final String? tradeType;
  final String? orderId;
  final bool cancel;
  final double nanoSecond;

  MarketTransaction({
    this.id,
    this.marketPlace,
    this.secId,
    this.execId,
    this.execType,
    this.side,
    this.prevExecId,
    this.dateTrans,
    this.symbol,
    this.quantity,
    this.price,
    this.sequence,
    this.tradeType,
    this.orderId,
    this.cancel = false,
    this.nanoSecond = 0.0,
  });

  factory MarketTransaction.fromJson(Map<String, dynamic> json) {
    return MarketTransaction(
      id: json['id'],
      marketPlace: json['marketPlace'],
      secId: json['secId'],
      execId: json['execId'],
      execType: json['execType'],
      side: json['side'],
      prevExecId: json['prevExecId'],
      dateTrans: json['dateTrans'] != null
          ? DateTime.parse(json['dateTrans'])
          : null,
      symbol: json['symbol'],
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      sequence: json['sequence'],
      tradeType: json['tradeType'],
      orderId: json['orderId'],
      cancel: json['cancel'] ?? false,
      nanoSecond: json['nanoSecond'] != null
          ? (json['nanoSecond'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'id': id,
      'marketPlace': marketPlace,
      'secId': secId,
      'execId': execId,
      'execType': execType,
      'side': side,
      'prevExecId': prevExecId,
      'dateTrans': dateTrans?.toIso8601String(),
      'symbol': symbol,
      'quantity': quantity,
      'price': price,
      'sequence': sequence,
      'tradeType': tradeType,
      'orderId': orderId,
      'cancel': cancel,
      'nanoSecond': nanoSecond,
    };
  }

  MarketTransaction copyWith({
    int? id,
    String? marketPlace,
    String? secId,
    String? execId,
    String? execType,
    String? side,
    String? prevExecId,
    DateTime? dateTrans,
    String? symbol,
    double? quantity,
    double? price,
    String? sequence,
    String? tradeType,
    String? orderId,
    bool? cancel,
    double? nanoSecond,
  }) {
    return MarketTransaction(
      id: id ?? this.id,
      marketPlace: marketPlace ?? this.marketPlace,
      secId: secId ?? this.secId,
      execId: execId ?? this.execId,
      execType: execType ?? this.execType,
      side: side ?? this.side,
      prevExecId: prevExecId ?? this.prevExecId,
      dateTrans: dateTrans ?? this.dateTrans,
      symbol: symbol ?? this.symbol,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      sequence: sequence ?? this.sequence,
      tradeType: tradeType ?? this.tradeType,
      orderId: orderId ?? this.orderId,
      cancel: cancel ?? this.cancel,
      nanoSecond: nanoSecond ?? this.nanoSecond,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketTransaction && other.execId == execId;
  }

  @override
  int get hashCode => execId.hashCode;

  @override
  String toString() =>
      'MarketTransaction[execId=$execId, symbol=$symbol, price=$price]';
}
