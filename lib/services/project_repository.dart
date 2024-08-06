// project_repository.dart

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'dart:async';
import '../models/lead.dart';

class ProjectRepository {
  final Client client;
  final Databases databases;
  final Account account;

  ProjectRepository({required this.client})
      : databases = Databases(client),
        account = Account(client);

  Future<List<Lead>> getLeads() async {
    try {
      final user = await account.get();

      final propertyLeads = await _getPropertyLeads(user.$id);
      final buyerLeads = await _getBuyerLeads(user.$id);

      print([...propertyLeads, ...buyerLeads]);

      return [...propertyLeads, ...buyerLeads];
    } catch (e) {
      print('Error fetching leads: $e');
      return [];
    }
  }

  Future<List<Lead>> _getPropertyLeads(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: '66a217bc0001534c6851',
        collectionId: 'property_lead',
        // queries: [
        //   Query.equal('associateDetails', userId),
        // ],
      );

      return response.documents
          .map((doc) => Lead.fromMap(doc.data, doc.$id))
          .toList();
    } catch (e) {
      print('Error fetching property leads: $e');
      return [];
    }
  }

  Future<List<Lead>> _getBuyerLeads(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: '66a217bc0001534c6851',
        collectionId: 'buyer_lead',
        // queries: [
        //   Query.equal('associateDetails', userId),
        // ],
      );

      return response.documents
          .map((doc) => Lead.fromMap(doc.data, doc.$id))
          .toList();
    } catch (e) {
      print('Error fetching buyer leads: $e');
      return [];
    }
  }
}
