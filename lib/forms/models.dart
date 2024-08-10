import 'package:dart_appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LeadAction { purchaseFrom, sellTo, rentTo, toLet }

enum PropertyType {
  flat,
  house,
  commercialBuilding,
  commercialPlots,
  residentialPlots
}

enum FurnishingType { fullyFurnished, semiFurnished, unFurnished }

extension FurnishingTypeExtension on FurnishingType {
  String get value {
    switch (this) {
      case FurnishingType.fullyFurnished:
        return 'fullyFurnished';
      case FurnishingType.semiFurnished:
        return 'semiFurnished';
      case FurnishingType.unFurnished:
        return 'unFurnished';
    }
  }
}

enum ConstructionStatus {
  ready,
  underConstruction,
  noConstruction,
  nonUsableConstruction
}

extension ConstructionStatusExtension on ConstructionStatus {
  String get value {
    switch (this) {
      case ConstructionStatus.ready:
        return 'ready';
      case ConstructionStatus.underConstruction:
        return 'underConstruction';
      case ConstructionStatus.noConstruction:
        return 'noConstruction';
      case ConstructionStatus.nonUsableConstruction:
        return 'nonUsableConstruction';
    }
  }
}

enum Facing {
  north,
  south,
  east,
  west,
  northEast,
  northWest,
  southEast,
  southWest
}

extension FacingExtension on Facing {
  String get value {
    switch (this) {
      case Facing.north:
        return 'north';
      case Facing.south:
        return 'south';
      case Facing.east:
        return 'east';
      case Facing.west:
        return 'west';
      case Facing.northEast:
        return 'northEast';
      case Facing.northWest:
        return 'northWest';
      case Facing.southEast:
        return 'southEast';
      case Facing.southWest:
        return 'southWest';
    }
  }
}

enum PropertyVudaType { vuda, nonVuda, vudaLP }

extension PropertyVudaTypeExtension on PropertyVudaType {
  String get value {
    switch (this) {
      case PropertyVudaType.vuda:
        return 'vuda';
      case PropertyVudaType.nonVuda:
        return 'nonVuda';
      case PropertyVudaType.vudaLP:
        return 'vudaLP';
    }
  }
}

enum ListedBy { owner, dealer, agent, employee, ambassador, other }

enum PropertyLeadStatus {
  leadReceived,
  mututalAgreementDone,
  rennovationDone,
  inMarket,
  tokenAmountGiven,
  primaryRegistrationDone,
  loanInProcess,
  registrationScheduled,
  finalRegistrationDone,
  commisionReceived
}

extension ListedByExtension on ListedBy {
  String get value {
    switch (this) {
      case ListedBy.owner:
        return 'owner';
      case ListedBy.dealer:
        return 'dealer';
      case ListedBy.agent:
        return 'agent';
      case ListedBy.employee:
        return 'employee';
      case ListedBy.ambassador:
        return 'ambassador';
      case ListedBy.other:
        return 'other';
    }
  }
}

enum ReferredBy { owner, dealer, agent, employee, customer, other }

extension ReferredByExtension on ReferredBy {
  String get value {
    switch (this) {
      case ReferredBy.owner:
        return 'owner';
      case ReferredBy.dealer:
        return 'dealer';
      case ReferredBy.agent:
        return 'agent';
      case ReferredBy.employee:
        return 'employee';
      case ReferredBy.customer:
        return 'customer';
      case ReferredBy.other:
        return 'other';
    }
  }
}

class LatLng {
  final double latitude;
  final double longitude;
  final String description;

  LatLng(this.latitude, this.longitude, this.description);

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'dedscription': description,
    };
  }

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      json['latitude'] as double,
      json['longitude'] as double,
      json['description'] as String,
    );
  }
}

class LatLng1 {
  final double latitude;
  final double longitude;
  final String description;

  LatLng1(this.latitude, this.longitude, this.description);

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'description': description
    };
  }

  @override
  String toString() {
    return 'LatLng1(latitude: $latitude, longitude: $longitude, description: $description)';
  }

  factory LatLng1.fromJson(Map<String, dynamic> json) {
    return LatLng1(
      json['latitude'] as double,
      json['longitude'] as double,
      json['description'] as String,
    );
  }
}

// Declare 1st Here  Step 1 : #################################################

class LeadFormData {
  LeadAction? action;
  List<PropertyType> propertyTypes = [];
  Map<String, dynamic> leadDetails = {};
  String? roughAddress;
  String? exactAddress;
  LatLng? customerVisitLocation;
  LatLng? exactVisitLocation;
  String? videoLink;
  String? description;
  List<String> documents = [];
  List<String> photos = [];
  double? costPrice;
  double? sellingPrice;
  double? commissionPercentage;
  DateTime? deadlineToSell;
  String? preferredTenant;
  double? preferredAdvance;
  double? propertyRent;
  ListedBy? listedBy;
  String? listerName;
  String? listerPhoneNumber;
  String? sellerName;
  String? sellerPhoneNumber;
  List<LatLng1>? preferredLocations;
  String? callTranscription;
  String? buyerPhoneNumber;
  String? buyerName;
  double? buyerBudget;
  List<Facing> facings = [];
  bool? alsoWantToSell;
  LatLng? buyerLocation;
  String? buyerOccupation;
  String? buyerComments;
  ReferredBy? referredBy;
  String? referrerId;
  String? referrerPhone;
  String? referrerName;
  String? buyerEmail;
  List<LatLng1> get preferredLocationsFromDetails =>
      (leadDetails['preferredLocations'] as List<dynamic>?)
          ?.map((e) => LatLng1.fromJson(e))
          .toList() ??
      [];

  LeadFormData();

  //To convert the declared variable to json , Step 2: #########################

  Map<String, dynamic> toJson() {
    return {
      'action': action?.toString(),
      'propertyTypes': propertyTypes.map((e) => e.toString()).toList(),
      'leadDetails': leadDetails,
      'roughAddress': roughAddress,
      'exactAddress': exactAddress,
      'customerVisitLocation': customerVisitLocation?.toJson(),
      'exactVisitLocation': exactVisitLocation?.toJson(),
      'videoLink': videoLink,
      'description': description,
      'documents': documents,
      'photos': photos,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'commissionPercentage': commissionPercentage,
      'deadlineToSell': deadlineToSell?.toIso8601String(),
      'preferredTenant': preferredTenant,
      'preferredAdvance': preferredAdvance,
      'propertyRent': propertyRent,
      'listedBy': listedBy?.toString(),
      'listerName': listerName,
      'listerPhoneNumber': listerPhoneNumber,
      'sellerName': sellerName,
      'sellerPhoneNumber': sellerPhoneNumber,
      'preferredLocations': preferredLocations!.map((e) => e.toJson()).toList(),
      'callTranscription': callTranscription,
      'buyerPhoneNumber': buyerPhoneNumber,
      'buyerName': buyerName,
      'buyerBudget': buyerBudget,
      'facings': facings.map((e) => e.toString()).toList(),
      'alsoWantToSell': alsoWantToSell,
      'buyerLocation': buyerLocation?.toJson(),
      'buyerOccupation': buyerOccupation,
      'buyerComments': buyerComments,
      'referredBy': referredBy?.toString(),
      'referrerId': referrerId,
      'referrerPhone': referrerPhone,
      'referrerName': referrerName,
      'buyerEmail': buyerEmail,
    };
  }

  //To Copy the Form Data as it is updated Step 3: ###########################

  LeadFormData copyWith({
    LeadAction? action,
    List<PropertyType>? propertyTypes,
    Map<String, dynamic>? leadDetails,
    String? roughAddress,
    String? exactAddress,
    LatLng? customerVisitLocation,
    LatLng? exactVisitLocation,
    String? videoLink,
    String? description,
    List<String>? documents,
    List<String>? photos,
    double? costPrice,
    double? sellingPrice,
    double? commissionPercentage,
    DateTime? deadlineToSell,
    String? preferredTenant,
    double? preferredAdvance,
    double? propertyRent,
    ListedBy? listedBy,
    String? listerName,
    String? listerPhoneNumber,
    String? sellerName,
    String? sellerPhoneNumber,
    List<LatLng1>? preferredLocations,
    String? callTranscription,
    String? buyerPhoneNumber,
    String? buyerName,
    double? buyerBudget,
    List<Facing>? facings,
    bool? alsoWantToSell,
    LatLng? buyerLocation,
    String? buyerOccupation,
    String? buyerComments,
    ReferredBy? referredBy,
    String? referrerId,
    String? referrerPhone,
    String? referrerName,
    String? buyerEmail,
  }) {
    //To Collect everything and display whenever updated Step 4: ###############
    return LeadFormData()
      ..action = action ?? this.action
      ..propertyTypes = propertyTypes ?? this.propertyTypes
      ..leadDetails = leadDetails ?? this.leadDetails
      ..roughAddress = roughAddress ?? this.roughAddress
      ..exactAddress = exactAddress ?? this.exactAddress
      ..customerVisitLocation =
          customerVisitLocation ?? this.customerVisitLocation
      ..exactVisitLocation = exactVisitLocation ?? this.exactVisitLocation
      ..videoLink = videoLink ?? this.videoLink
      ..description = description ?? this.description
      ..documents = documents ?? this.documents
      ..photos = photos ?? this.photos
      ..costPrice = costPrice ?? this.costPrice
      ..sellingPrice = sellingPrice ?? this.sellingPrice
      ..commissionPercentage = commissionPercentage ?? this.commissionPercentage
      ..deadlineToSell = deadlineToSell ?? this.deadlineToSell
      ..preferredTenant = preferredTenant ?? this.preferredTenant
      ..preferredAdvance = preferredAdvance ?? this.preferredAdvance
      ..propertyRent = propertyRent ?? this.propertyRent
      ..listedBy = listedBy ?? this.listedBy
      ..listerName = listerName ?? this.listerName
      ..listerPhoneNumber = listerPhoneNumber ?? this.listerPhoneNumber
      ..sellerName = sellerName ?? this.sellerName
      ..sellerPhoneNumber = sellerPhoneNumber ?? this.sellerPhoneNumber
      ..preferredLocations = preferredLocations ?? this.preferredLocations
      ..callTranscription = callTranscription ?? this.callTranscription
      ..buyerPhoneNumber = buyerPhoneNumber ?? this.buyerPhoneNumber
      ..buyerName = buyerName ?? this.buyerName
      ..buyerEmail = buyerEmail ?? this.buyerEmail
      ..buyerBudget = buyerBudget ?? this.buyerBudget
      ..facings = facings ?? this.facings
      ..alsoWantToSell = alsoWantToSell ?? this.alsoWantToSell
      ..buyerLocation = buyerLocation ?? this.buyerLocation
      ..buyerOccupation = buyerOccupation ?? this.buyerOccupation
      ..buyerComments = buyerComments ?? this.buyerComments
      ..referredBy = referredBy ?? this.referredBy
      ..referrerId = referrerId ?? this.referrerId
      ..referrerPhone = referrerPhone ?? this.referrerPhone
      ..referrerName = referrerName ?? this.referrerName;
  }
}

final LeadFormProvider =
    StateNotifierProvider<LeadFormNotifier, LeadFormData>((ref) {
  return LeadFormNotifier();
});

//The Provider and the switch Case to Update upon filling the Form Field Step 5:

class LeadFormNotifier extends StateNotifier<LeadFormData> {
  LeadFormNotifier() : super(LeadFormData());

  void updateAction(LeadAction action) {
    state = state.copyWith(action: action);
  }

  void updatePropertyTypes(List<PropertyType> types) {
    state = state.copyWith(propertyTypes: types);
  }

  void updateLeadDetails(Map<String, dynamic> details) {
    state = state.copyWith(leadDetails: {...state.leadDetails, ...details});
  }

  void updatePreferredLocations(List<LatLng1> locations) {
    state = state.copyWith(preferredLocations: locations);
  }

  void clearLeadDetails() {
    state = state.copyWith(leadDetails: {});
  }

  void updateFormField<T>(String field, T value) {
    switch (field) {
      case 'roughAddress':
        state = state.copyWith(roughAddress: value as String);
        break;
      case 'exactAddress':
        state = state.copyWith(exactAddress: value as String);
        break;
      case 'customerVisitLocation':
        state = state.copyWith(customerVisitLocation: value as LatLng);
        break;
      case 'exactVisitLocation':
        state = state.copyWith(exactVisitLocation: value as LatLng);
        break;
      case 'videoLink':
        state = state.copyWith(videoLink: value as String);
        break;
      case 'description':
        state = state.copyWith(description: value as String);
        break;
      case 'documents':
        state = state.copyWith(documents: value as List<String>);
        break;
      case 'photos':
        state = state.copyWith(photos: value as List<String>);
        break;
      case 'costPrice':
        state = state.copyWith(costPrice: value as double);
        break;
      case 'sellingPrice':
        state = state.copyWith(sellingPrice: value as double);
        break;
      case 'commissionPercentage':
        state = state.copyWith(commissionPercentage: value as double);
        break;
      case 'deadlineToSell':
        state = state.copyWith(deadlineToSell: value as DateTime);
        break;
      case 'preferredTenant':
        state = state.copyWith(preferredTenant: value as String);
        break;
      case 'preferredAdvance':
        state = state.copyWith(preferredAdvance: value as double);
        break;
      case 'propertyRent':
        state = state.copyWith(propertyRent: value as double);
        break;
      case 'listedBy':
        state = state.copyWith(listedBy: value as ListedBy);
        break;
      case 'listerName':
        state = state.copyWith(listerName: value as String);
        break;
      case 'listerPhoneNumber':
        state = state.copyWith(listerPhoneNumber: value as String);
        break;
      case 'sellerName':
        state = state.copyWith(sellerName: value as String);
        break;
      case 'sellerPhoneNumber':
        state = state.copyWith(sellerPhoneNumber: value as String);
        break;
      case 'preferredLocations':
        state = state.copyWith(preferredLocations: value as List<LatLng1>);
        break;
      case 'callTranscription':
        state = state.copyWith(callTranscription: value as String);
        break;
      case 'buyerPhoneNumber':
        state = state.copyWith(buyerPhoneNumber: value as String);
        break;
      case 'buyerName':
        state = state.copyWith(buyerName: value as String);
        break;
      case 'buyerBudget':
        state = state.copyWith(buyerBudget: value as double);
        break;
      case 'facings':
        state = state.copyWith(facings: value as List<Facing>);
        break;
      case 'alsoWantToSell':
        state = state.copyWith(alsoWantToSell: value as bool);
        break;
      case 'buyerLocation':
        state = state.copyWith(buyerLocation: value as LatLng);
        break;
      case 'buyerEmail':
        state = state.copyWith(buyerEmail: value as String);
        break;
      case 'buyerOccupation':
        state = state.copyWith(buyerOccupation: value as String);
        break;
      case 'buyerComments':
        state = state.copyWith(buyerComments: value as String);
        break;
      case 'referredBy':
        state = state.copyWith(referredBy: value as ReferredBy);
        break;
      case 'referrerId':
        state = state.copyWith(referrerId: value as String);
        break;
      case 'referrerPhone':
        state = state.copyWith(referrerPhone: value as String);
        break;
      case 'referrerName':
        state = state.copyWith(referrerName: value as String);
        break;
      default:
        // Handle unknown fields or provide feedback
        break;
    }
  }
}
