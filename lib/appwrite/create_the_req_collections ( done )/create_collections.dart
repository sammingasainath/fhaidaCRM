import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/enums.dart';

void main() async {
  final client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('669f8f9b000b799d55e7')
    ..setKey(
        '220aace5f82ea041af7db7ea672e20ae0a8fb48957b49bc1dca6a98cd871ac8db81273c2af5bbb51444afa4670557d5c6fb63d034874bac8ea1ce0d182248aedbe046becd7563ff0056aa9b4b69ed38ab2d134289eb394d7bcc50de587911364bfd21d5dfcaf99599c8044d82d9656f53253b36dc8db78c3ddb854f2f0bd8441');

  final databases = Databases(client);
  final String databaseId = '66a217bc0001534c6851';

  try {
    // Create Property Lead collection
    final propertyLeadCollection = await databases.createCollection(
      databaseId: databaseId,
      collectionId: 'property_lead',
      name: 'Property Lead',
    );

    // Create attributes for Property Lead
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'ageOfProperty',
        size: 255,
        xrequired: true);
    await databases.createEnumAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'furnishingType',
        elements: ['FURNISHED', 'SEMI_FURNISHED', 'UNFURNISHED'],
        xrequired: true);
    await databases.createEnumAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'constructionStatus',
        elements: ['READY_TO_MOVE', 'UNDER_CONSTRUCTION'],
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'areaInSft',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'builtAreaInSft',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'totalFloors',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'widthOfPlot',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'lengthOfPlot',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'totalBedrooms',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'masterBedrooms',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'bathrooms',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'balconies',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'externalMaintenanceRating',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'internalMaintenanceRating',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'roughAddress',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'customerVisitLocation',
        size: 255,
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'customerVisitLat',
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'customerVisitLng',
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'exactAddress',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'exactVisitLocation',
        size: 255,
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'exactVisitLat',
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'exactVisitLng',
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'videoLink',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'description',
        size: 65535,
        xrequired: false);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'costPrice',
        xrequired: false);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'sellingPrice',
        xrequired: false);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'commissionPercentage',
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'deadlineToSell',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'totalFloorsInApartment',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'totalBlocksInApartment',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'floorOfFlat',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'preferredTenant',
        size: 255,
        xrequired: false);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'preferredAdvance',
        xrequired: false);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: propertyLeadCollection.$id,
        key: 'propertyRent',
        xrequired: false);

    // Create Buyer/Tenant Lead collection
    final buyerLeadCollection = await databases.createCollection(
      databaseId: databaseId,
      collectionId: 'buyer_lead',
      name: 'Buyer/Tenant Lead',
    );

    // Create attributes for Buyer/Tenant Lead
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'callTranscription',
        size: 65535,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerPhoneNumber',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerName',
        size: 255,
        xrequired: true);
    await databases.createIntegerAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'numberOfBedrooms',
        xrequired: false);
    await databases.createBooleanAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'alsoWantToSell',
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerLocation',
        size: 255,
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerLat',
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerLng',
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerBudget',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerEmail',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerOccupation',
        size: 255,
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: buyerLeadCollection.$id,
        key: 'buyerComments',
        size: 65535,
        xrequired: false);

    // Create Seller/Owner Details collection
    final sellerCollection = await databases.createCollection(
      databaseId: databaseId,
      collectionId: 'seller',
      name: 'Seller/Owner Details',
    );

    // Create attributes for Seller/Owner Details
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: sellerCollection.$id,
        key: 'sellerName',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: sellerCollection.$id,
        key: 'sellerPhoneNumber',
        size: 255,
        xrequired: true);
    await databases.createBooleanAttribute(
        databaseId: databaseId,
        collectionId: sellerCollection.$id,
        key: 'alsoWantToBuy',
        xrequired: false);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: sellerCollection.$id,
        key: 'sellerComments',
        size: 65535,
        xrequired: false);

    // Create Associate Details collection
    final associateCollection = await databases.createCollection(
      databaseId: databaseId,
      collectionId: 'associate',
      name: 'Associate Details',
    );

    // Create attributes for Associate Details
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: associateCollection.$id,
        key: 'assoName',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: associateCollection.$id,
        key: 'assoPhone',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: associateCollection.$id,
        key: 'assoEmail',
        size: 255,
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: associateCollection.$id,
        key: 'assoType',
        size: 255,
        xrequired: true);

    // Create LatLng Locations Lead collection
    final latLngCollection = await databases.createCollection(
      databaseId: databaseId,
      collectionId: 'latlng',
      name: 'LatLng Locations Lead',
    );

    // Create attributes for LatLng Locations Lead
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: latLngCollection.$id,
        key: 'latitude',
        xrequired: true);
    await databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: latLngCollection.$id,
        key: 'longitude',
        xrequired: true);
    await databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: latLngCollection.$id,
        key: 'description',
        size: 255,
        xrequired: true);

    // Create relationships
    await databases.createRelationshipAttribute(
      databaseId: databaseId,
      collectionId: propertyLeadCollection.$id,
      relatedCollectionId: sellerCollection.$id,
      key: 'seller',
      type: RelationshipType.oneToOne,
    );
    await databases.createRelationshipAttribute(
      databaseId: databaseId,
      collectionId: propertyLeadCollection.$id,
      relatedCollectionId: associateCollection.$id,
      key: 'associate',
      type: RelationshipType.oneToOne,
    );
    await databases.createRelationshipAttribute(
      databaseId: databaseId,
      collectionId: buyerLeadCollection.$id,
      relatedCollectionId: latLngCollection.$id,
      key: 'preferredLocations',
      type: RelationshipType.manyToMany,
    );

    print('Collections and attributes created successfully');
  } catch (e) {
    print('Error creating collections and attributes: $e');
  }
}
