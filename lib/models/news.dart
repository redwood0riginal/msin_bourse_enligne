class MarketNews {
  final String objectType = 'MarketNews';
  final String? headline;
  final String? encodedHeadlineLen;
  final String? encodedHeadline;
  final String? urgency;
  final String? noLinesOfText;
  final List<String>? linesOfText;
  final String? urlLink;

  MarketNews({
    this.headline,
    this.encodedHeadlineLen,
    this.encodedHeadline,
    this.urgency,
    this.noLinesOfText,
    this.linesOfText,
    this.urlLink,
  });

  factory MarketNews.fromJson(Map<String, dynamic> json) {
    return MarketNews(
      headline: json['headline'],
      encodedHeadlineLen: json['encodedHeadlineLen'],
      encodedHeadline: json['encodedHeadline'],
      urgency: json['urgency'],
      noLinesOfText: json['noLinesOfText'],
      linesOfText: json['linesOfText'] != null
          ? List<String>.from(json['linesOfText'])
          : null,
      urlLink: json['urlLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType,
      'headline': headline,
      'encodedHeadlineLen': encodedHeadlineLen,
      'encodedHeadline': encodedHeadline,
      'urgency': urgency,
      'noLinesOfText': noLinesOfText,
      'linesOfText': linesOfText,
      'urlLink': urlLink,
    };
  }

  MarketNews copyWith({
    String? headline,
    String? encodedHeadlineLen,
    String? encodedHeadline,
    String? urgency,
    String? noLinesOfText,
    List<String>? linesOfText,
    String? urlLink,
  }) {
    return MarketNews(
      headline: headline ?? this.headline,
      encodedHeadlineLen: encodedHeadlineLen ?? this.encodedHeadlineLen,
      encodedHeadline: encodedHeadline ?? this.encodedHeadline,
      urgency: urgency ?? this.urgency,
      noLinesOfText: noLinesOfText ?? this.noLinesOfText,
      linesOfText: linesOfText ?? this.linesOfText,
      urlLink: urlLink ?? this.urlLink,
    );
  }

  @override
  String toString() => 'MarketNews[headline=$headline]';
}
