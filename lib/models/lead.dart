// lead_model.dart
import '../forms/models.dart';

enum LeadType { sell, buy, rent, tolet }

class Lead {
  final String id;
  final LeadType leadType;

  // Common fields
  // final String? associateDetailsId;
  final String? status;

  // Property Lead fields
  final String? furnishingType;
  final String? constructionStatus;
  final String? builtAreaInSft;
  final String? totalFloors;
  final String? widthOfPlot;
  final String? lengthOfPlot;
  final String? totalBedrooms;
  final String? masterBedrooms;
  final String? bathrooms;
  final String? balconies;
  final String? externalMaintenanceRating;
  final String? internalMaintenanceRating;
  final String? roughAddress;
  final String? customerVisitLocation;
  final double? customerVisitLat;
  final double? customerVisitLng;
  final String? exactAddress;
  final String? exactVisitLocation;
  final double? exactVisitLat;
  final double? exactVisitLng;
  final String? videoLink;
  final String? description;
  final double? costPrice;
  final double? sellingPrice;
  final double? commissionPercentage;
  final String? deadlineToSell;
  final String? totalFloorsInApartment;
  final String? totalBlocksInApartment;
  final String? floorOfFlat;
  final String? preferredTenant;
  final double? preferredAdvance;
  final double? propertyRent;
  // final String? ownerDetailsId;
  final double? ageOfProperty;
  final List<String>? facing;
  final String? areaInSft;
  final List<String>? photoUrls;
  final List<String>? documentUrls;

  // Buyer Lead fields
  final String? callTranscription;
  final String? buyerPhoneNumber;
  final String? buyerName;
  final int? numberOfBedrooms;
  final bool? alsoWantToSell;
  final String? buyerLocation;
  final double? buyerLat;
  final double? buyerLng;
  final String? buyerBudget;
  final String? buyerEmail;
  final String? buyerOccupation;
  final String? buyerComments;
  final List<dynamic>? preferredLocations;
  final String? propertyTyp;
  final List<String>? preferredProperties;
  final List<dynamic>? events;

  Lead(
      {required this.id,
      required this.leadType,
      // this.associateDetailsId,
      this.status,
      this.furnishingType,
      this.constructionStatus,
      this.builtAreaInSft,
      this.totalFloors,
      this.widthOfPlot,
      this.lengthOfPlot,
      this.totalBedrooms,
      this.masterBedrooms,
      this.bathrooms,
      this.balconies,
      this.externalMaintenanceRating,
      this.internalMaintenanceRating,
      this.roughAddress,
      this.customerVisitLocation,
      this.customerVisitLat,
      this.customerVisitLng,
      this.exactAddress,
      this.exactVisitLocation,
      this.exactVisitLat,
      this.exactVisitLng,
      this.videoLink,
      this.description,
      this.costPrice,
      this.sellingPrice,
      this.commissionPercentage,
      this.deadlineToSell,
      this.totalFloorsInApartment,
      this.totalBlocksInApartment,
      this.floorOfFlat,
      this.preferredTenant,
      this.preferredAdvance,
      this.propertyRent,
      // this.ownerDetailsId,
      this.ageOfProperty,
      this.facing,
      this.areaInSft,
      this.photoUrls,
      this.documentUrls,
      this.callTranscription,
      this.buyerPhoneNumber,
      this.buyerName,
      this.numberOfBedrooms,
      this.alsoWantToSell,
      this.buyerLocation,
      this.buyerLat,
      this.buyerLng,
      this.buyerBudget,
      this.buyerEmail,
      this.buyerOccupation,
      this.buyerComments,
      this.preferredLocations,
      this.propertyTyp,
      this.preferredProperties,
      this.events});

  // lead_model.dart

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'leadType': leadType.toString(),
      'status': status,
      'furnishingType': furnishingType,
      'constructionStatus': constructionStatus,
      'builtAreaInSft': builtAreaInSft,
      'totalFloors': totalFloors,
      'widthOfPlot': widthOfPlot,
      'lengthOfPlot': lengthOfPlot,
      'totalBedrooms': totalBedrooms,
      'masterBedrooms': masterBedrooms,
      'bathrooms': bathrooms,
      'balconies': balconies,
      'externalMaintenanceRating': externalMaintenanceRating,
      'internalMaintenanceRating': internalMaintenanceRating,
      'roughAddress': roughAddress,
      'customerVisitLocation': customerVisitLocation,
      'customerVisitLat': customerVisitLat,
      'customerVisitLng': customerVisitLng,
      'exactAddress': exactAddress,
      'exactVisitLocation': exactVisitLocation,
      'exactVisitLat': exactVisitLat,
      'exactVisitLng': exactVisitLng,
      'videoLink': videoLink,
      'description': description,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'commissionPercentage': commissionPercentage,
      'deadlineToSell': deadlineToSell,
      'totalFloorsInApartment': totalFloorsInApartment,
      'totalBlocksInApartment': totalBlocksInApartment,
      'floorOfFlat': floorOfFlat,
      'preferredTenant': preferredTenant,
      'preferredAdvance': preferredAdvance,
      'propertyRent': propertyRent,
      'ageOfProperty': ageOfProperty,
      'facing': facing,
      'areaInSft': areaInSft,
      'photoUrls': photoUrls,
      'documentUrls': documentUrls,
      'callTranscription': callTranscription,
      'buyerPhoneNumber': buyerPhoneNumber,
      'buyerName': buyerName,
      'numberOfBedrooms': numberOfBedrooms,
      'alsoWantToSell': alsoWantToSell,
      'buyerLocation': buyerLocation,
      'buyerLat': buyerLat,
      'buyerLng': buyerLng,
      'buyerBudget': buyerBudget,
      'buyerEmail': buyerEmail,
      'buyerOccupation': buyerOccupation,
      'buyerComments': buyerComments,
      'preferredLocations': preferredLocations,
      'propertyTyp': propertyTyp,
      'preferredProperties': preferredProperties,
      'events': events
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map, String id) {
    return Lead(
      id: id,
      leadType: map['leadType'] == 'sell'
          ? LeadType.sell
          : map['leadType'] == 'buy'
              ? LeadType.buy
              : map['leadType'] == 'rent'
                  ? LeadType.rent
                  : map['leadType'] == 'tolet'
                      ? LeadType.tolet
                      : throw ArgumentError('Invalid leadType value'),

      // associateDetails: map['associateDetails'] as Map<String, dynamic>?,
      status: map['status'] as String?,
      furnishingType: map['furnishingType'] as String?,
      constructionStatus: map['constructionStatus'] as String?,
      builtAreaInSft: map['builtAreaInSft'] as String?,
      totalFloors: map['totalFloors'] as String?,
      widthOfPlot: map['widthOfPlot'] as String?,
      lengthOfPlot: map['lengthOfPlot'] as String?,
      totalBedrooms: map['totalBedrooms'] as String?,
      masterBedrooms: map['masterBedrooms'] as String?,
      bathrooms: map['bathrooms'] as String?,
      balconies: map['balconies'] as String?,
      externalMaintenanceRating: map['externalMaintenanceRating'] as String?,
      internalMaintenanceRating: map['internalMaintenanceRating'] as String?,
      roughAddress: map['roughAddress'] as String?,
      customerVisitLocation: map['customerVisitLocation'] as String?,
      customerVisitLat: _parseDouble(map['customerVisitLat']),
      customerVisitLng: _parseDouble(map['customerVisitLng']),
      exactAddress: map['exactAddress'] as String?,
      exactVisitLocation: map['exactVisitLocation'] as String?,
      exactVisitLat: _parseDouble(map['exactVisitLat']),
      exactVisitLng: _parseDouble(map['exactVisitLng']),
      videoLink: map['videoLink'] as String?,
      description: map['description'] as String?,
      costPrice: _parseDouble(map['costPrice']),
      sellingPrice: _parseDouble(map['sellingPrice']),
      commissionPercentage: _parseDouble(map['commissionPercentage']),
      deadlineToSell: map['deadlineToSell'] as String?,
      totalFloorsInApartment: map['totalFloorsInApartment'] as String?,
      totalBlocksInApartment: map['totalBlocksInApartment'] as String?,
      floorOfFlat: map['floorOfFlat'] as String?,
      preferredTenant: map['preferredTenant'] as String?,
      preferredAdvance: _parseDouble(map['preferredAdvance']),
      propertyRent: _parseDouble(map['propertyRent']),
      // ownerDetails: map['ownerDetails'] as Map<String, dynamic>?,
      ageOfProperty: _parseDouble(map['ageOfProperty']),
      facing: (map['facing'] as List<dynamic>?)?.cast<String>(),
      areaInSft: map['areaInSft'] as String?,
      photoUrls: (map['photoUrls'] as List<dynamic>?)?.cast<String>(),
      documentUrls: (map['documentUrls'] as List<dynamic>?)?.cast<String>(),
      callTranscription: map['callTranscription'] as String?,
      buyerPhoneNumber: map['buyerPhoneNumber'] as String?,
      buyerName: map['buyerName'] as String?,
      numberOfBedrooms: map['numberOfBedrooms'] as int?,
      alsoWantToSell: map['alsoWantToSell'] as bool?,
      buyerLocation: map['buyerLocation'] as String?,
      buyerLat: _parseDouble(map['buyerLat']),
      buyerLng: _parseDouble(map['buyerLng']),
      buyerBudget: map['buyerBudget'] as String?,
      buyerEmail: map['buyerEmail'] as String?,
      buyerOccupation: map['buyerOccupation'] as String?,
      buyerComments: map['buyerComments'] as String?,
      preferredLocations: (map['preferred_locations'] as List<dynamic>?),
      propertyTyp: map['propertyTyp'] as String?,
      preferredProperties:
          (map['preferredProperties'] as List<dynamic>?)?.cast<String>(),
      events: (map['events'] as List<dynamic>?),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}
