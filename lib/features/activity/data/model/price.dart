class Price {
  String? numberDecimal;

  Price({this.numberDecimal});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(numberDecimal: json['\$numberDecimal'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'\$numberDecimal': numberDecimal};
  }

  double get value => double.tryParse(numberDecimal ?? '0') ?? 0;
}
