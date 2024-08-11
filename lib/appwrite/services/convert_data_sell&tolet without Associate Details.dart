import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:file_picker/file_picker.dart';

import '../../forms/models.dart';

Future<Map<String, dynamic>> convertDataWithoutAsso(Map<String, dynamic> data,
    String leadtype, String sellRentProperties) async {
  // Ensure non-null values for seller details

  final List<String> validStatusOptions = [
    'leadReceived',
    'mututalAgreementDone',
    'rennovationDone',
    'inMarket',
    'tokenAmountGiven',
    'primaryRegistrationDone',
    'loanInProcess',
    'registrationScheduled',
    'finalRegistrationDone',
    'commisionReceived',
  ];

  // var data2 = {
  //   'sellerName': data['ownerName'] ?? '',
  //   'sellerPhoneNumber': data['ownerPhoneNumber'] ?? '',
  //   'alsoWantToBuy': data['alsoWantToBuy'] ?? false, // Ensure boolean value
  // };

  // var sellerID;
  // try {
  //   sellerID = await createSellerDetails(data2);
  //   print('Seller Details created: $sellerID');
  // } catch (e) {
  //   print('Error creating Seller Details: $e');
  // }

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
  List<Facing> facings = ((data['facing'] as List<dynamic>?) ?? [])
      .map((e) => Facing.values.firstWhere(
          (f) => f.toString().split('.').last == e.toString(),
          orElse: () => Facing.north))
      .toList();

  List<String> facingValues = facings.map((f) => f.value).toList();

  ListedBy listedBy = ListedBy.values.firstWhere(
    (e) => e.toString().split('.').last == data['listedBy'],
    orElse: () => ListedBy.agent, // default value if not found
  );

  // var data3 = {
  //   'assoName': data['associateName'] ?? '',
  //   'assoPhone': data['associateNumber'] ?? '',
  //   'associateType': listedBy.toString().split('.').last,
  // };

  // var associateID;
  // try {
  //   associateID = await createAssociateDetails(data3);
  //   print('Associate Details created: $associateID');
  // } catch (e) {
  //   print('Error creating Associate Details: $e');
  // }

  List<String> photoUrls = [];
  try {
    photoUrls = await uploadFiles(data['photos'] ?? [], '66a9e5990027b4011eb6');
    print(photoUrls);
  } catch (e) {
    print('Error uploading photos: $e');
  }

  List<PlatformFile> documents = ((data['documents'] as List<dynamic>?) ?? [])
      .map((item) => item as PlatformFile)
      .toList();

  List<String> documentUrls = [];
  try {
    documentUrls = await uploadPlatformFiles(documents, '66a9e5c90002d611a9db');
    print(documentUrls);
  } catch (e) {
    print('Error uploading documents: $e');
  }

  String formattedLeadType =
      leadtype.toLowerCase().contains('tolet') ? 'tolet' : 'sell';

  var data1 = {
    'ageOfProperty': double.tryParse(data['ageOfProperty'].toString()),
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
    'externalMaintenanceRating': data['externalMaintenanceRating'].toString(),
    'internalMaintenanceRating': data['internalMaintenanceRating'].toString(),
    'roughAddress': data['roughAddress'],
    'exactAddress': data['exactAddress'],
    'videoLink': data['videoLink'],
    'costPrice': double.tryParse(data['costPrice'].toString()),
    'sellingPrice': double.tryParse(data['sellingPrice'].toString()),
    'commissionPercentage':
        double.tryParse(data['commissionPercentage'].toString()),
    'deadlineToSell': data['deadlineToSell'].toString(),
    // 'ownerDetails': sellerID,
    'builtAreaInSft': data['builtAreaInSft'].toString(),
    'widthOfPlot': data['widthOfPlot'].toString(),
    'lengthOfPlot': data['lengthOfPlot'].toString(),
    'preferredTenant': data['preferredTenant'],
    'preferredAdvance': double.tryParse(data['preferredAdvance'].toString()),
    'propertyRent': double.tryParse(data['propertyRent'].toString()),
    'customerVisitLocation': data['customerVisitLocation'],
    'customerVisitLat': double.tryParse(data['customerVisitLat'].toString()),
    'customerVisitLng': double.tryParse(data['customerVisitLng'].toString()),
    'exactVisitLocation': data['exactVisitLocation'],
    'exactVisitLat': double.tryParse(data['exactVisitLat'].toString()),
    'exactVisitLng': double.tryParse(data['exactVisitLng'].toString()),
    'description': data['description'],
    // 'associateDetails': associateID,
    'leadType': formattedLeadType,
    'photoUrls': photoUrls,
    'documentUrls': documentUrls,
    'propertyTyp': sellRentProperties,
    'status': validStatusOptions.contains(data['status'])
        ? data['status']
        : 'leadReceived'
  };

  return data1;
}
