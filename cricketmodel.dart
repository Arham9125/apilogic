class CricketMatch {
  final String id;
  final String name;
  final String matchType;
  final String status;
  final List<String> teams;
  final List<Map<String, dynamic>> score;

  CricketMatch({
    required this.id,
    required this.name,
    required this.matchType,
    required this.status,
    required this.teams,
    required this.score,
  });

  factory CricketMatch.fromJson(Map<String, dynamic> json) {
    return CricketMatch(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      matchType: json['matchType'] ?? '',
      status: json['status'] ?? '',
      teams: (json['teams'] as List<dynamic>).map((team) => team as String).toList(),
      score: List<Map<String, dynamic>>.from(json['score']),
    );
  }
}
