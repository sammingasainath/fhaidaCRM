// import 'package:flutter/material.dart';
// import 'package:anucivil_client/providers/shared_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:anucivil_client/services/user_details_service.dart';
// import '/providers/shared_provider.dart';

// final userDetailsNotifierProvider =
//     StateNotifierProvider<UserDetailsNotifier, void>((ref) {
//   final userDetailsService = ref.watch(userDetailsServiceProvider);
//   return UserDetailsNotifier(userDetailsService, ref);
// });

// class UserDetailsNotifier extends StateNotifier<void> {
//   final UserDetailsService _userDetailsService;
//   final Ref _ref;

//   UserDetailsNotifier(this._userDetailsService, this._ref) : super(null);

//   Future<void> saveUserDetails({
//     required String name,
//     required String email,
//     required String phone,
//     required String street,
//     required String town,
//     required String district,
//     required String state,
//     required String pincode,
//     required String gUrl,
//     required String profileImg,
//     required BuildContext context,
//   }) async {
//     try {
//       await _userDetailsService.saveUserDetails(
//         name: name,
//         email: email,
//         phone: phone,
//         street: street,
//         town: town,
//         district: district,
//         state: state,
//         pincode: pincode,
//         gUrl: gUrl,
//         profileImg: profileImg,
//       );

//       // Update the user details completion state
//       _ref.read(userDetailsCompleteProvider.notifier).checkUserDetails();

//       // Navigate to the dashboard
//       Navigator.pushReplacementNamed(context, '/');
//     } catch (e) {
//       _showErrorDialog(context, e.toString());
//     }
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }
