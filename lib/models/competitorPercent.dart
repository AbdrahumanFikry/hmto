class CompetitorPercents {
  int competitorId;
  String sallesRateStock;
  String sallesRateMoney;

  CompetitorPercents({
    this.competitorId,
    this.sallesRateStock,
    this.sallesRateMoney,
  });

  CompetitorPercents.fromJson(Map<String, dynamic> json) {
    competitorId = json['competitor_id'];
    sallesRateStock = json['salles_rate_stock'];
    sallesRateMoney = json['salles_rate_money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['competitor_id'] = this.competitorId;
    data['salles_rate_stock'] = this.sallesRateStock;
    data['salles_rate_money'] = this.sallesRateMoney;
    return data;
  }
}
