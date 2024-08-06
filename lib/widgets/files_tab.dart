import 'package:anucivil_client/models/lead.dart';
import 'package:anucivil_client/services/file_fetcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesTab extends StatelessWidget {
  final Lead lead;
  var photos;
  var documents;

  FilesTab({required this.lead});

  @override
  Widget build(BuildContext context) {
    if (lead.photoUrls != null) {
      photos = getImages('66a9e5990027b4011eb6', lead.photoUrls!);
    } else {
      photos = [];
    }

    if (lead.documentUrls != null) {
      documents = getDocuments('66a9e5c90002d611a9db', lead.documentUrls!);
    } else {
      documents = [];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          if (photos.isNotEmpty) ...[
            Text(
              'Property Photos',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            CarouselSlider.builder(
              itemCount: photos.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Image.network(photos[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      child: Image.network(
                        photos[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'No photos available',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          SizedBox(height: 20.0),
          if (documents.isNotEmpty) ...[
            Text(
              'Documents',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = documents[index];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text('Document ${index + 1}'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ] else
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'No documents available',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
