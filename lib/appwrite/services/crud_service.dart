import 'package:dart_appwrite/dart_appwrite.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'package:anucivil_client/models/lead.dart';
import 'dart:io' as io;

List<models.Document> events = [];

// import 'package:appwrite/appwrite.dart';

final client = Client()
  ..setEndpoint('https://cloud.appwrite.io/v1')
  ..setProject('669f8f9b000b799d55e7')
  ..setKey(
      '220aace5f82ea041af7db7ea672e20ae0a8fb48957b49bc1dca6a98cd871ac8db81273c2af5bbb51444afa4670557d5c6fb63d034874bac8ea1ce0d182248aedbe046becd7563ff0056aa9b4b69ed38ab2d134289eb394d7bcc50de587911364bfd21d5dfcaf99599c8044d82d9656f53253b36dc8db78c3ddb854f2f0bd8441');

final databases = Databases(client);
final String databaseId = '66a217bc0001534c6851';
Storage storage = Storage(client);

// Property Lead CRUD operations
Future<void> createPropertyLead(var data) async {
  try {
    final document = await databases.createDocument(
      databaseId: databaseId,
      collectionId: 'property_lead',
      documentId: ID.unique(),
      data: data,
    );
    print('Property Lead created: ${document.$id}');
  } catch (e) {
    print('Error creating Property Lead: $e');
  }
}

Future<void> readPropertyLead(var data) async {
  try {
    final document = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'property_lead',
      documentId: data, // Replace with actual document ID
    );
    print('Property Lead read: ${document.data}');
  } catch (e) {
    print('Error reading Property Lead: $e');
  }
}

Future<void> updatePropertyLead(var data, var id) async {
  try {
    final document = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: 'property_lead',
        documentId: id, // Replace with actual document ID
        data: data);

    print('Property Lead updated: ${document.$id}');
  } catch (e) {
    print('Error updating Property Lead: $e');
  }
}

Future<void> deletePropertyLead(var data) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: 'property_lead',
      documentId: data, // Replace with actual document ID
    );
    print('Property Lead deleted');
  } catch (e) {
    print('Error deleting Property Lead: $e');
  }
}

// Buyer Lead CRUD operations
Future<void> createBuyerLead(var data) async {
  try {
    final document = await databases.createDocument(
        databaseId: databaseId,
        collectionId: 'buyer_lead',
        documentId: ID.unique(),
        data: data);
    print('Buyer Lead created: ${document.$id}');
  } catch (e) {
    print('Error creating Buyer Lead: $e');
  }
}

Future<Map<String, dynamic>> readBuyerLead(var data) async {
  try {
    final document = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'buyer_lead',
      documentId: data, // Replace with actual document ID
    );
    print('Buyer Lead read: ${document.data}');
    return document.data;
  } catch (e) {
    return {};
    print('Error reading Buyer Lead: $e');
  }
}

Future<List<Lead>> readLeadsWithEvent(String eventId) async {
  List<Lead> leads = [];
  try {
    var eventDocument = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'events',
      documentId: eventId,
    );

    // Extract propertyLead data
    var propertyLeadData = eventDocument.data['propertyLead'];
    if (propertyLeadData is List) {
      for (var propertyLead in propertyLeadData) {
        if (propertyLead is Map<String, dynamic>) {
          leads.add(Lead.fromMap(propertyLead, propertyLead['\$id'] ?? ''));
        }
      }
    }

    // Extract buyerLeads data
    var buyerLeadsData = eventDocument.data['buyerLeads'];
    if (buyerLeadsData is List) {
      for (var buyerLead in buyerLeadsData) {
        if (buyerLead is Map<String, dynamic>) {
          leads.add(Lead.fromMap(buyerLead, buyerLead['\$id'] ?? ''));
        }
      }
    }
  } catch (e) {
    print('Error reading Leads: $e');
  }
  return leads;
}

Future<bool> getEventIds(DateTime date) async {
  try {
    // Convert the input date to the start and end of the day
    // final startOfDay = DateTime(date.year, date.month, date.day).toUtc();
    // final endOfDay =
    //     startOfDay.add(Duration(days: 1)).subtract(Duration(microseconds: 1));

    final response = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: 'events',
      queries: [
        Query.equal('eventDate', date.toIso8601String()),
        // Query.lessThan('eventDate', endOfDay.toIso8601String()),
      ],
    );

    events = response.documents.cast<models.Document>();

    if (events.isEmpty) {
      return false;
    } else {
      return true;
    }

    // for (var item in events) {
    //   print('Events: ${item.data['eventDate']}');
    // }
  } catch (e) {
    print('Error fetching events: $e');
    return true;
  }
}

Future<void> updateBuyerLead(var data, var id) async {
  try {
    final document = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: 'buyer_lead',
        documentId: id, // Replace with actual document ID
        data: data);
    print('Buyer Lead updated: ${document.$id}');
  } catch (e) {
    print('Error updating Buyer Lead: $e');
  }
}

Future<void> deleteBuyerLead(var data) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: 'buyer_lead',
      documentId: '66a217bc0001534c6851', // Replace with actual document ID
    );
    print('Buyer Lead deleted');
  } catch (e) {
    print('Error deleting Buyer Lead: $e');
  }
}

// Seller/Owner Details CRUD operations

Future<String> createSellerDetails(var data) async {
  try {
    final document = await databases.createDocument(
      databaseId: databaseId,
      collectionId: 'seller',
      documentId: ID.unique(),
      data: {
        'sellerName': data['sellerName'],
        'sellerPhoneNumber': data['sellerName'],
        'alsoWantToBuy': data['alsoWantToBuy'],
        'sellerComments': data['comments'],
      },
    );
    print('Seller Details created: ${document.$id}');
    return document.$id;
  } catch (e) {
    print('Error creating Seller Details: $e');
    return '';
  }
}

Future<void> readSellerDetails(var data, String docId) async {
  try {
    final document = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'seller',
      documentId: docId,
    );
    print('Seller Details read: ${document.data}');
  } catch (e) {
    print('Error reading Seller Details: $e');
  }
}

Future<void> updateSellerDetails(var data, String docId) async {
  try {
    final document = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: 'seller',
      documentId: docId,
      data: {
        'sellerComments': 'Interested in selling quickly, prefer cash payment',
      },
    );
    print('Seller Details updated: ${document.$id}');
  } catch (e) {
    print('Error updating Seller Details: $e');
  }
}

Future<void> deleteSellerDetails(var data, String docId) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: 'seller',
      documentId: docId,
    );
    print('Seller Details deleted');
  } catch (e) {
    print('Error deleting Seller Details: $e');
  }
}

// Associate Details CRUD operations

Future<String> createAssociateDetails(var data) async {
  try {
    final document = await databases.createDocument(
        databaseId: databaseId,
        collectionId: 'associate',
        documentId: ID.unique(),
        data: data);
    print('Associate Details created: ${document.$id}');
    return document.$id;
  } catch (e) {
    print('Error creating Associate Details: $e');
    return '';
  }
}

Future<void> readAssociateDetails(var data, String docId) async {
  try {
    final document = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'associate',
      documentId: docId,
    );
    print('Associate Details read: ${document.data}');
  } catch (e) {
    print('Error reading Associate Details: $e');
  }
}

Future<void> updateAssociateDetails(var data, String docId) async {
  try {
    final document = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: 'associate',
      documentId: docId,
      data: {
        'assoType': 'Lead Agent',
      },
    );
    print('Associate Details updated: ${document.$id}');
  } catch (e) {
    print('Error updating Associate Details: $e');
  }
}

Future<void> deleteAssociateDetails(var data, String docId) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: 'associate',
      documentId: docId,
    );
    print('Associate Details deleted');
  } catch (e) {
    print('Error deleting Associate Details: $e');
  }
}

// LatLng Locations Lead CRUD operations

Future<String> createLatLngLocation(var data) async {
  try {
    final document = await databases.createDocument(
      databaseId: databaseId,
      collectionId: 'latlng',
      documentId: ID.unique(),
      data: data,
    );
    print('LatLng Location created: ${document.$id}');
    return document.$id;
  } catch (e) {
    print('Error creating LatLng Location: $e');
    return '';
  }
}

Future<void> readLatLngLocation(var data, String docId) async {
  try {
    final document = await databases.getDocument(
      databaseId: databaseId,
      collectionId: 'latlng',
      documentId: docId,
    );
    print('LatLng Location read: ${document.data}');
  } catch (e) {
    print('Error reading LatLng Location: $e');
  }
}

Future<void> updateLatLngLocation(var data, String docId) async {
  try {
    final document = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: 'latlng',
      documentId: docId,
      data: {
        'description': 'City Center - Near Shopping Mall',
      },
    );
    print('LatLng Location updated: ${document.$id}');
  } catch (e) {
    print('Error updating LatLng Location: $e');
  }
}

Future<void> deleteLatLngLocation(var data, String docId) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: 'latlng',
      documentId: docId,
    );
    print('LatLng Location deleted');
  } catch (e) {
    print('Error deleting LatLng Location: $e');
  }
}

//uploadPhotos Functions

Future<String> uploadFile(String filePath, String bucketId) async {
  try {
    File file = File(filePath);
    String fileName = path.basename(file.path);

    final result = await storage.createFile(
      bucketId: bucketId,
      fileId: 'unique()',
      file: InputFile(
        filename: fileName,
        path: filePath,
      ),
    );

    print(result.$id);

    return result.$id;
  } catch (e) {
    print('Error uploading file: $e');
    return '';
  }
}

Future<List<String>> uploadFiles(
    List<String> filePaths, String bucketId) async {
  List<String> fileUrls = [];

  for (String filePath in filePaths) {
    String fileId = await uploadFile(filePath, bucketId);
    if (fileId != null) {
      fileUrls.add(fileId);
    }
  }

  return fileUrls;
}

Future<List<String>> uploadPlatformFiles(
    List<PlatformFile> platformFiles, String bucketId) async {
  List<String> fileUrls = [];

  for (PlatformFile platformFile in platformFiles) {
    String fileId = await uploadPlatformFile(platformFile, bucketId);
    if (fileId.isNotEmpty) {
      fileUrls.add(fileId);
    }
  }

  return fileUrls;
}

Future<String> uploadPlatformFile(
    PlatformFile platformFile, String bucketId) async {
  try {
    final result = await storage.createFile(
      bucketId: bucketId,
      fileId: 'unique()',
      file: InputFile(
        filename: platformFile.name,
        path: platformFile.path,
      ),
    );

    // Access the file ID correctly from the response
    return result.$id;
  } catch (e) {
    print('Error uploading file: $e');
    return '';
  }
}



// 'ageOfProperty': ageOfProperty,
//         'furnishingType': 'SEMI_FURNISHED',
//         'constructionStatus': 'READY_TO_MOVE',
//         'areaInSft': '1500',
//         'builtAreaInSft': '1200',
//         'totalFloors': '10',
//         'widthOfPlot': '30',
//         'lengthOfPlot': '50',
//         'totalBedrooms': '3',
//         'masterBedrooms': '1',
//         'bathrooms': '2',
//         'balconies': '1',
//         'externalMaintenanceRating': '4',
//         'internalMaintenanceRating': '4',
//         'roughAddress': '123 Main St, City',
//         'customerVisitLocation': 'Front Gate',
//         'customerVisitLat': 12.9716,
//         'customerVisitLng': 77.5946,
//         'exactAddress': '123 Main St, Apartment 4B, City',
//         'exactVisitLocation': 'Apartment 4B',
//         'exactVisitLat': 12.9716,
//         'exactVisitLng': 77.5946,
//         'videoLink': 'https://youtube.com/example',
//         'description': 'A beautiful apartment in the heart of the city',
//         'costPrice': 5000000,
//         'sellingPrice': 5500000,
//         'commissionPercentage': 2,
//         'deadlineToSell': '2023-12-31',
//         'totalFloorsInApartment': '15',
//         'totalBlocksInApartment': '3',
//         'floorOfFlat': '4',
//         'preferredTenant': 'Family',
//         'preferredAdvance': 100000,
//         'propertyRent': 25000,
