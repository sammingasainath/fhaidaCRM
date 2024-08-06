import 'package:appwrite/appwrite.dart';

Client client = Client();

Client appwriteInitialize() {

  return client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('669f8f9b000b799d55e7')
      .setSelfSigned(
          status:
              true);
              
               // For self signed certificates, only use for development

               
}

final appwriteClient = appwriteInitialize();
final storage1 = Storage(appwriteClient);

