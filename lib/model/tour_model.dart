class Tour {
  final String tourName;
  final String aboutTour;
  final String questCount;
  final String totalPrice;
  final String coverImage;
  final List<String> allImages;

  Tour({
    required this.tourName,
    required this.aboutTour,
    required this.questCount,
    required this.totalPrice,
    required this.coverImage,
    required this.allImages,
  });

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      tourName: map['tourName'] ?? '',
      aboutTour: map['aboutTour'] ?? '',
      questCount: map['questCount'] ?? '',
      totalPrice: map['totalPrice'] ?? '',
      coverImage: map['coverImage'] ?? '',
      allImages: List<String>.from(map['allImages'] ?? []),
    );
  }
}
