import 'package:anucivil_client/services/user_details_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailsServiceProvider = Provider<UserDetailsService>((ref) {
  return UserDetailsService();
});
