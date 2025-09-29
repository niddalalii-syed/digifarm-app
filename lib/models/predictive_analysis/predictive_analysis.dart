class PredictiveAnalysisData {
  PredictiveAnalysisData({
    required this.yeildExpected,
    required this.yeildPredicted,
    required this.fertilizerRecommendation,
    required this.soilHealth,
  });

  late final String yeildExpected;
  late final String yeildPredicted;
  late final String fertilizerRecommendation;
  late final String soilHealth;

  PredictiveAnalysisData.fromJson(Map<String, dynamic> json) {
    yeildExpected = json['yeild_expected'];
    yeildPredicted = json['yeild_predicted'];
    fertilizerRecommendation = json['fertilizer_recommendation'];
    soilHealth = json['soil_health'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yeild_expected'] = yeildExpected;
    _data['yeild_predicted'] = yeildPredicted;
    _data['fertilizer_recommendation'] = fertilizerRecommendation;
    _data['soil_health'] = soilHealth;
    return _data;
  }
}
