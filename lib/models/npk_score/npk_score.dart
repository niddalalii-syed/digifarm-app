// npk_score_model.dart
class NPKScore {
  final double score;

  NPKScore({required this.score});

  // Factory method to create NPKScore from JSON
  factory NPKScore.fromJson(Map<String, dynamic> json) {
    return NPKScore(
      score: json['score'],
    );
  }

  // Method to convert NPKScore to JSON format
  Map<String, dynamic> toJson() {
    return {
      'score': score,
    };
  }
}
