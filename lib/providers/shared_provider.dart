import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';

final clientProvider = Provider<Client>((ref) {
  Client client = Client();
  client
      .setEndpoint(
          'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
      .setProject(
          '669f8f9b000b799d55e7'); // Replace with your Appwrite project ID
  return client;
});

final accountProvider = Provider<Account>((ref) {
  final client = ref.watch(clientProvider);
  return Account(client);
});

final authStateProvider = StreamProvider<bool>((ref) async* {
  final account = ref.watch(accountProvider);
  while (true) {
    try {
      final user = await account.get();
      yield user != null;
    } catch (_) {
      yield false;
    }
    await Future.delayed(Duration(seconds: 5));
  }
});

// If you need a UserDetailsService, you can create a provider for it here
// final userDetailsServiceProvider = Provider<UserDetailsService>((ref) {
//   return UserDetailsService(ref.watch(clientProvider));
// });