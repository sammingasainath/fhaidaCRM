import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../forms/models.dart';

import 'package:dart_appwrite/dart_appwrite.dart';

Future<Map<dynamic, dynamic>> convertData1(
    data, leadtype, List<String> preferredProperties) async {
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
    listedBy = ListedBy.agent; // default value in case of error
  }

  var data3 = {
    'assoName': data['associateName'],
    'assoPhone': data['associateNumber'],
    'associateType':
        listedBy.toString().split('.').last // Convert to string for JSON
  };

  List<String> latLngIds = [];

  if (data['preferredLocations'] != null) {
    for (var loc in data['preferredLocations']) {
      // Assuming loc is an instance of LatLng1 with properties: latitude, longitude, description
      final latLngData = {
        'latitude': loc.latitude,
        'longitude': loc.longitude,
        'description': loc.description,
      };

      final latLngId = await createLatLngLocation(latLngData);
      if (latLngId.isNotEmpty) {
        print(latLngId);
        latLngIds.add(latLngId);
      }
    }
  }

  var associateID = await createAssociateDetails(data3);

  var data1 = {
    'preferred_locations': latLngIds,
    'callTranscription': data['callTranscription'],
    'buyerPhoneNumber': data['buyerPhoneNumber'],
    'buyerName': data['buyerName'],
    'numberOfBedrooms': data['numberOfBedrooms'],
    'alsoWantToSell': data['alsoWantToSell'],
    'buyerLocation': data['buyerLocation'],
    'buyerLat': data['buyerLat'],
    'buyerLng': data['buyerLng'],
    'buyerBudget': data['buyerBudget'],
    'buyerEmail': data['buyerEmail'],
    'buyerOccupation': data['buyerOccupation'],
    'buyerComments': data['buyerComments'],
    'associateDetails': associateID,
    'facing': facingValues,
    'leadType': leadtype,
    'preferredProperties': preferredProperties,
    'status': 'leadReceived'
  };

  return data1;
}
