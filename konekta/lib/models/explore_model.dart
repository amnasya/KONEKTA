class ExploreCampaign {
  final int id;
  final String title;
  final String brand;
  final String category;
  final String description;
  final double budget;
  final int deadlineDays;
  final int minFollowers;
  final List<String> platforms;
  final bool isOpen;

  const ExploreCampaign({
    required this.id,
    required this.title,
    required this.brand,
    required this.category,
    required this.description,
    required this.budget,
    required this.deadlineDays,
    required this.minFollowers,
    required this.platforms,
    required this.isOpen,
  });

  factory ExploreCampaign.fromJson(Map<String, dynamic> j) => ExploreCampaign(
        id:           (j['id'] as num).toInt(),
        title:        j['title']       as String,
        brand:        j['brand']       as String,
        category:     j['category']    as String,
        description:  j['description'] as String,
        budget:       (j['budget'] as num).toDouble(),
        deadlineDays: (j['deadlineDays'] as num).toInt(),
        minFollowers: (j['minFollowers'] as num).toInt(),
        platforms:    List<String>.from(j['platforms'] as List),
        isOpen:       j['isOpen'] as bool,
      );

  String get deadlineLabel =>
      deadlineDays > 0 ? '$deadlineDays days left' : 'Closed';

  String get budgetLabel {
    final n = budget.toInt();
    if (n >= 1000000) return 'Rp ${(n / 1000000).toStringAsFixed(1)}jt';
    if (n >= 1000) return 'Rp ${(n / 1000).toStringAsFixed(0)}rb';
    return 'Rp $n';
  }

  String get minFollowersLabel {
    if (minFollowers >= 1000000) return '${(minFollowers / 1000000).toStringAsFixed(1)}M';
    if (minFollowers >= 1000) return '${(minFollowers / 1000).toStringAsFixed(0)}K';
    return '$minFollowers';
  }
}

class ExploreBrand {
  final int id;
  final String name;
  final String category;
  final bool verified;

  const ExploreBrand({
    required this.id,
    required this.name,
    required this.category,
    required this.verified,
  });

  factory ExploreBrand.fromJson(Map<String, dynamic> j) => ExploreBrand(
        id:       (j['id'] as num).toInt(),
        name:     j['name']     as String,
        category: j['category'] as String,
        verified: j['verified'] as bool,
      );
}

class ExploreData {
  final List<ExploreCampaign> campaigns;
  final List<ExploreBrand> brands;

  const ExploreData({required this.campaigns, required this.brands});

  factory ExploreData.fromJson(Map<String, dynamic> j) => ExploreData(
        campaigns: (j['campaigns'] as List)
            .map((c) => ExploreCampaign.fromJson(c as Map<String, dynamic>))
            .toList(),
        brands: (j['brands'] as List)
            .map((b) => ExploreBrand.fromJson(b as Map<String, dynamic>))
            .toList(),
      );
}
