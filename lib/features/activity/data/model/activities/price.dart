class Price {
  String? numberDecimal;

  Price({this.numberDecimal});

  factory Price.json(Map<String, dynamic> json) {
    return Price(numberDecimal: json['numberDecimal'] as String?);
  }

  Map<String, dynamic> toId() {
    return {'$numberDecimal': numberDecimal};
  }
}
