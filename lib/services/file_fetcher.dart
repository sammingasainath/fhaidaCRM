import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;

String endpoint = 'https://cloud.appwrite.io/v1';
String project = '669f8f9b000b799d55e7';

List<String> getImages(String bucketId, List<String> fileId) {
  Client client = Client()
      .setEndpoint(endpoint)
      .setProject(project)
      .setSelfSigned(status: true);

  Storage storage = Storage(client);
  List<String> urls = [];

  for (var item in fileId) {
    // Use the result as needed

    var string =
        'https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/${item}/preview?project=$project';
    urls.add(string);
  }

  print(urls);
  return urls;
}

List<String> getDocuments(String bucketId, List<String> fileId) {
  Client client = Client()
      .setEndpoint(endpoint)
      .setProject(project)
      .setSelfSigned(status: true);

  Storage storage = Storage(client);
  List<String> urls = [];

  for (var item in fileId) {
    // Use the result as needed

    var string =
        'https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/${item}/download?project=$project';
    urls.add(string);
  }

  print(urls);
  return urls;
}
