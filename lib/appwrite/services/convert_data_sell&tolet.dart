import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../forms/models.dart';

import 'package:dart_appwrite/dart_appwrite.dart';

Future<Map<String, dynamic>> convertData(
    data, leadtype, sellRentProperties) async {
  var data2 = {
    // 'sellerComments': data['comments'],
    'sellerName': data['ownerName'],
    'sellerPhoneNumber': data['ownerPhoneNumber'],
    'alsoWantToBuy': data['alsoWantToBuy'],
  };

  var sellerID = await createSellerDetails(data2);
  print(sellerID);
  FurnishingType furnishingType;
  try {
    furnishingType = FurnishingType.values.firstWhere(
      (e) => e.toString().split('.').last == data['furnishingType'],
      orElse: () => FurnishingType.unFurnished, // default value if not found
    );
  } catch (e) {
    furnishingType =
        FurnishingType.unFurnished; // default value in case of error
  }

  ConstructionStatus constructionStatus;
  try {
    constructionStatus = ConstructionStatus.values.firstWhere(
      (e) => e.toString().split('.').last == data['furnishingType'],
      orElse: () =>
          ConstructionStatus.noConstruction, // default value if not found
    );
  } catch (e) {
    constructionStatus =
        ConstructionStatus.noConstruction; // default value in case of error
  }

  // Convert 'facing' (list of Facing enums)
// Convert 'facing' (list of Facing enums)
  List<Facing> facings = List<Facing>.from(data['facing']);
  List<String> facingValues = facings.map((f) => f.value).toList();

  ListedBy listedBy;

  try {
    listedBy = ListedBy.values.firstWhere(
      (e) => e.toString().split('.').last == data['listedBy'],
      orElse: () => ListedBy.agent, // default value if not found
    );
  } catch (e) {
    listedBy = ListedBy.agent;

    // default value in case of error
  }

  var data3 = {
    'assoName': data['associateName'],
    'assoPhone': data['associateNumber'],
    'associateType':
        listedBy.toString().split('.').last // Convert to string for JSON
  };

  var associateID = await createAssociateDetails(data3);

  List<String> photoUrls = [];

  photoUrls = await uploadFiles(data['photos'], '66a9e5990027b4011eb6');

  List<String> documentUrls = [];

  documentUrls =
      await uploadPlatformFiles(data['documents'], '66a9e5c90002d611a9db');

  print(photoUrls);

  var data1 = {
    'ageOfProperty': data['ageOfProperty'],
    'furnishingType': furnishingType.value,
    'constructionStatus': constructionStatus.value,
    'facing': facingValues,
    'areaInSft': data['areaInSft'].toString(),
    'totalFloorsInApartment': data['totalFloorsInApartment'].toString(),
    'totalBlocksInApartment': data['totalBlocksInApartment'].toString(),
    'totalFloors': data['totalFloors'].toString(),
    'floorOfFlat': data['floorOfFlat'].toString(),
    'totalBedrooms': data['totalBedrooms'].toString(),
    'masterBedrooms': data['masterBedrooms'].toString(),
    'bathrooms': data['bathrooms'].toString(),
    'balconies': data['balconies'].toString(),
    'externalMaintenanceRating': data['externalMaintenanceRating'],
    'internalMaintenanceRating': data['internalMaintenanceRating'],
    'roughAddress': data['roughAddress'],
    'exactAddress': data['exactAddress'],
    'videoLink': data['videoLink'],
    'costPrice': data['costPrice'],
    'sellingPrice': data['sellingPrice'],
    'commissionPercentage': data['commissionPercentage'],
    'deadlineToSell': data['deadlineToSell'],
    'ownerDetails': sellerID,
    'builtAreaInSft': data['builtAreaInSft'],
    'widthOfPlot': data['widthOfPlot'],
    'lengthOfPlot': data['lengthOfPlot'],
    'preferredTenant': data['preferredTenant'],
    'preferredAdvance': data['preferredAdvance'],
    'propertyRent': data['propertyRent'],
    'customerVisitLocation': data['customerVisitLocation'],
    'customerVisitLat': data['customerVisitLat'],
    'customerVisitLng': data['customerVisitLng'],
    'exactVisitLocation': data['exactVisitLocation'],
    'exactVisitLat': data['exactVisitLat'],
    'exactVisitLng': data['exactVisitLng'],
    'description': data['description'],
    'associateDetails': associateID,
    'leadType': leadtype,
    'photoUrls': photoUrls,
    'documentUrls': documentUrls,
    'propertyTyp': sellRentProperties,
    'status':'Action Required'
  };

  //Seller Details

  // Associate Details
  print('sellerId :${sellerID}');

  return data1;
}
