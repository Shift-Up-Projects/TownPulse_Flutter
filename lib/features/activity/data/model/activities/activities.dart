import 'price.dart';

class Activities {
  String? id;
  String? title;
  String? description;
  String? location;
  String? mapUrl;
  double? latitude;
  double? longitude;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? category;
  Price? price;
  int? capacity;
  String? creator;
  DateTime? createdAt;

  Activities({
    this.id,
    this.title,
    this.description,
    this.location,
    this.mapUrl,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
    this.status,
    this.category,
    this.price,
    this.capacity,
    this.creator,
    this.createdAt,
  });

  factory Activities.fromId68e0f97bde0777bc871f1d5dTitleDescriptionLocationMapUrlHttpsMapsAppGooGlBNvCiYacPxk84MyH8Latitude247136Longitude466753StartDate20251201T180000000ZEndDate20251201T230000000ZStatusUpcomingCategoryMusicPriceNumberDecimal1505Capacity500Creator68d023537fc7b161f0f399fdCreatedAt20251004T103955015Z(
    Map<String, dynamic> json,
  ) {
    return Activities(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      mapUrl: json['map_url'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      status: json['status'] as String?,
      category: json['category'] as String?,
      price: json['price'] == null
          ? null
          : Price.json(json['price'] as Map<String, dynamic>),
      capacity: json['capacity'] as int?,
      creator: json['creator'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic>
  toId68e0f97bde0777bc871f1d5dTitleDescriptionLocationMapUrlHttpsMapsAppGooGlBNvCiYacPxk84MyH8Latitude247136Longitude466753StartDate20251201T180000000ZEndDate20251201T230000000ZStatusUpcomingCategoryMusicPriceNumberDecimal1505Capacity500Creator68d023537fc7b161f0f399fdCreatedAt20251004T103955015Z() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'location': location,
      'map_url': mapUrl,
      'latitude': latitude,
      'longitude': longitude,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'category': category,
      'price': price?.toId(),
      'capacity': capacity,
      'creator': creator,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
