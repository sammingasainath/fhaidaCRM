import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';

final appwriteServiceProvider = Provider((ref) => AppwriteService());

class AppwriteService {
  final Client client = Client();
  late final Account account;

  AppwriteService() {
    client
        .setEndpoint(
            'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
        .setProject(
            '669f8f9b000b799d55e7'); // Replace with your Appwrite project ID
    account = Account(client);
  }

  Future<void> createPhoneSession(String phoneNumber) async {
    try {
      // await account.createPhoneSession(
      //   userId: ID.unique(),
      //   phone: phoneNumber,
      // );
    } catch (e) {
      print('Error creating phone session: $e');
      rethrow;
    }
  }

  Future<void> updatePhoneSession(String userId, String otp) async {
    try {
      await account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
    } catch (e) {
      print('Error updating phone session: $e');
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return await account.get();
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }
}
