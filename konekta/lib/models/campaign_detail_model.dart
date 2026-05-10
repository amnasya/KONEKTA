class CampaignBrand {
  final String name;
  final String category;
  final String? logo;
  final bool verified;

  const CampaignBrand({
    required this.name,
    required this.category,
    this.logo,
    required this.verified,
  });

  factory CampaignBrand.fromJson(Map<String, dynamic> j) => CampaignBrand(
        name:     j['name']     as String,
        category: j['category'] as String,
        logo:     j['logo']     as String?,
        verified: j['verified'] as bool,
      );
}

class CampaignRequirements {
  final int minFollowers;
  final List<String> platforms;
  final String contentType;
  final String audience;

  const CampaignRequirements({
    required this.minFollowers,
    required this.platforms,
    required this.contentType,
    required this.audience,
  });

  factory CampaignRequirements.fromJson(Map<String, dynamic> j) =>
      CampaignRequirements(
        minFollowers: (j['minFollowers'] as num).toInt(),
        platforms:    List<String>.from(j['platforms'] as List),
        contentType:  j['contentType'] as String,
        audience:     j['audience']    as String,
      );
}

class CampaignDetail {
  final int id;
  final String title;
  final String description;
  final double budget;
  final int deadline;
  final String status;
  final CampaignBrand brand;
  final CampaignRequirements requirements;
  final List<String> deliverables;
  final bool alreadyApplied;

  const CampaignDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.status,
    required this.brand,
    required this.requirements,
    required this.deliverables,
    required this.alreadyApplied,
  });

  bool get isOpen => status == 'OPEN';

  factory CampaignDetail.fromJson(Map<String, dynamic> j) => CampaignDetail(
        id:             (j['id'] as num).toInt(),
        title:          j['title']       as String,
        description:    j['description'] as String,
        budget:         (j['budget'] as num).toDouble(),
        deadline:       (j['deadline'] as num).toInt(),
        status:         j['status']      as String,
        brand:          CampaignBrand.fromJson(j['brand'] as Map<String, dynamic>),
        requirements:   CampaignRequirements.fromJson(j['requirements'] as Map<String, dynamic>),
        deliverables:   List<String>.from((j['details'] as Map)['deliverables'] as List),
        alreadyApplied: j['alreadyApplied'] as bool,
      );
}
