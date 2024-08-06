import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:file_picker/file_picker.dart';

import '../../forms/models.dart';

Future<Map<String, dynamic>> convertData(Map<String, dynamic> data,
    String leadtype, String sellRentProperties) async {
  // Ensure non-null values for seller details
  var data2 = {
    'sellerName': data['ownerName'] ?? '',
    'sellerPhoneNumber': data['ownerPhoneNumber'] ?? '',
    'alsoWantToBuy': data['alsoWantToBuy'] ?? false, // Ensure boolean value
  };

  var sellerID;
  try {
    sellerID = await createSellerDetails(data2);
    print('Seller Details created: $sellerID');
  } catch (e) {
    print('Error creating Seller Details: $e');
  }

  // Convert and handle enum values
  FurnishingType furnishingType = FurnishingType.values.firstWhere(
    (e) => e.toString().split('.').last == data['furnishingType'],
    orElse: () => FurnishingType.unFurnished, // default value if not found
  );

  ConstructionStatus constructionStatus = ConstructionStatus.values.firstWhere(
    (e) => e.toString().split('.').last == data['constructionStatus'],
    orElse: () =>
        ConstructionStatus.noConstruction, // default value if not found
  );

  // Convert 'facing' (list of Facing enums)
  List<Facing> facings = List<Facing>.from(data['facing'] ?? []);
  List<String> facingValues = facings.map((f) => f.value).toList();

  ListedBy listedBy = ListedBy.values.firstWhere(
    (e) => e.toString().split('.').last == data['listedBy'],
    orElse: () => ListedBy.agent, // default value if not found
  );

  var data3 = {
    'assoName': data['associateName'] ?? '',
    'assoPhone': data['associateNumber'] ?? '',
    'associateType': listedBy.toString().split('.').last,
  };

  var associateID;
  try {
    associateID = await createAssociateDetails(data3);
    print('Associate Details created: $associateID');
  } catch (e) {
    print('Error creating Associate Details: $e');
  }

  List<String> photoUrls = [];
  try {
    photoUrls = await uploadFiles(data['photos'] ?? [], '66a9e5990027b4011eb6');
    print(photoUrls);
  } catch (e) {
    print('Error uploading photos: $e');
  }

  List<PlatformFile> documents = (data['documents'] as List<dynamic>)
      .map((item) => item as PlatformFile)
      .toList();

  List<String> documentUrls = [];
  try {
    documentUrls = await uploadPlatformFiles(documents, '66a9e5c90002d611a9db');
    print(documentUrls);
  } catch (e) {
    print('Error uploading documents: $e');
  }

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
    'status': 'Action Required'
  };

  return data1;
}
