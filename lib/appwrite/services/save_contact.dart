import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveContact(
    String displayName,
    String middleName,
    String familyName,
    String givenName,
    String jobTitle,
    String company,
    String phone,
    String type) async {
  if (await requestContactPermission()) {
    final newContact = Contact(
      displayName: displayName,
      middleName: middleName,
      familyName: familyName,
      givenName: givenName,
      jobTitle: jobTitle,
      company: company,
      phones: [Item(label: type, value: phone)],
    );
    await ContactsService.addContact(newContact);
  } else {
    print('Permission to save contact denied');
  }
}

Future<bool> requestContactPermission() async {
  PermissionStatus status = await Permission.contacts.status;
  if (!status.isGranted) {
    status = await Permission.contacts.request();
  }
  return status.isGranted;
}
