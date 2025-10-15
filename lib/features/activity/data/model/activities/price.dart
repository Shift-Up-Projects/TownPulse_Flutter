class Price {
  String? numberDecimal;

  Price({this.numberDecimal});

  factory Price.fromId68e0f97bde0777bc871f1d5dTitleDescriptionLocationMapUrlHttpsMapsAppGooGlBNvCiYacPxk84MyH8Latitude247136Longitude466753StartDate20251201T180000000ZEndDate20251201T230000000ZStatusUpcomingCategoryMusicPriceNumberDecimal1505Capacity500Creator68d023537fc7b161f0f399fdCreatedAt20251004T103955015Z(
    Map<String, dynamic> json,
  ) {
    return Price(numberDecimal: json['numberDecimal'] as String?);
  }

  Map<String, dynamic>
  toId68e0f97bde0777bc871f1d5dTitleDescriptionLocationMapUrlHttpsMapsAppGooGlBNvCiYacPxk84MyH8Latitude247136Longitude466753StartDate20251201T180000000ZEndDate20251201T230000000ZStatusUpcomingCategoryMusicPriceNumberDecimal1505Capacity500Creator68d023537fc7b161f0f399fdCreatedAt20251004T103955015Z() {
    return {'$numberDecimal': numberDecimal};
  }
}
