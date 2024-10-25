import 'package:anucivil_client/appwrite/services/convert_property_data_without_asso_while_edit.dart';
import 'package:anucivil_client/models/lead.dart';
import 'package:anucivil_client/services/file_fetcher.dart';
import 'package:anucivil_client/widgets/AssoOwnerdetailCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../forms/models.dart';
import 'package:anucivil_client/providers/navigation_provider.dart';
import 'package:anucivil_client/providers/project_provider.dart';
import 'dart:developer';

class FilesTab extends ConsumerStatefulWidget {
  final Lead lead;
  FilesTab({required this.lead});

  @override
  _FilesTabState createState() => _FilesTabState();
}

class _FilesTabState extends ConsumerState<FilesTab> {
  bool _isSaving = false;
  var photos;
  var documents;

  @override
  Widget build(
    BuildContext context,
  ) {
    Future<void> _uploadPhotos(BuildContext context) async {
      final formData = ref.watch(LeadFormProvider);
      final formNotifier = ref.read(LeadFormProvider.notifier);

      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      if (images.isNotEmpty) {
        final existingPhotos =
            formData.leadDetails?['photos'] as List<String>? ?? <String>[];
        final newPhotos = images.map((e) => e.path).toList();

        if (existingPhotos.length + newPhotos.length > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 12),
                  Text('You can upload a maximum of 10 photos.'),
                ],
              ),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(16),
            ),
          );
          return;
        }

        formNotifier.updateLeadDetails({
          'photos': [...existingPhotos, ...newPhotos],
        });
      }
    }

    Future<void> _uploadDocuments(BuildContext context) async {
      final formData = ref.watch(LeadFormProvider);
      final formNotifier = ref.read(LeadFormProvider.notifier);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        final existingDocs =
            formData.leadDetails?['documents'] as List<dynamic>? ??
                <PlatformFile>[];
        final newDocs = result.files;

        formNotifier.updateLeadDetails({
          'documents': [...existingDocs, ...newDocs],
        });
      }
    }

    late Map<String, dynamic> _editedData;
    _editedData = widget.lead.toMap();
    final formData = ref.watch(LeadFormProvider);
    final formNotifier = ref.read(LeadFormProvider.notifier);

    if (widget.lead.photoUrls != null) {
      photos = getImages('66a9e5990027b4011eb6', widget.lead.photoUrls!);
    } else {
      photos = [];
    }

    if (widget.lead.documentUrls != null) {
      documents =
          getDocuments('66a9e5c90002d611a9db', widget.lead.documentUrls!);
    } else {
      documents = [];
    }

    // Upload functions remain the same...
    // [Previous upload functions code here]

    Widget _buildPhotoPreview(List<String> photoPaths) {
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photoPaths.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(photoPaths[index]),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () {
                          final updatedPhotos = List<String>.from(photoPaths);
                          updatedPhotos.removeAt(index);
                          formNotifier.updateLeadDetails({
                            'photos': updatedPhotos,
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget _buildDocumentPreview(List<PlatformFile> documentFiles) {
      return Container(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: documentFiles.length,
          itemBuilder: (context, index) {
            final file = documentFiles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.description),
                      onPressed: () {
                        // Document viewing logic
                      },
                      label: Text(
                        file.name.length > 15
                            ? '${file.name.substring(0, 15)}...'
                            : file.name,
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, size: 16, color: Colors.red),
                        onPressed: () {
                          formNotifier.updateLeadDetails({
                            'documents': List<PlatformFile>.from(documentFiles)
                              ..removeAt(index),
                          });
                        },
                        constraints: BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        padding: EdgeInsets.all(4),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (photos.isNotEmpty) ...[
            Text(
              'Listed By',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            AssociateCard(
              associateName: widget.lead.toMap()['associateDetails']
                  ['assoName'],
              associateType: widget.lead.toMap()['associateDetails']
                  ['associateType'],
              associatePhone: widget.lead.toMap()['associateDetails']
                  ['assoPhone'],
            ),
            Text(
              'Owned By',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            AssociateCard(
              associateName: widget.lead.toMap()['ownerDetails']['sellerName'],
              associateType: widget.lead.toMap()['ownerDetails']
                      ['alsoWantToBuy']
                  ? 'Wants to Buy Also'
                  : 'Want to Sell Only',
              associatePhone: widget.lead.toMap()['ownerDetails']
                  ['sellerPhoneNumber'],
            ),
            Text(
              'Property Photos',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CarouselSlider.builder(
                itemCount: photos.length,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(photos[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
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
            ),
          ] else
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.photo_library_outlined,
                        size: 48, color: Colors.grey[600]),
                    SizedBox(height: 12),
                    Text(
                      'No photos available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            icon: Icon(Icons.add_photo_alternate),
            label: Text('Upload More Photos'),
            onPressed: () => _uploadPhotos(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (formData.leadDetails?['photos'] is List<String>)
            _buildPhotoPreview(
                formData.leadDetails?['photos'] as List<String> ?? []),
          SizedBox(height: 32),
          if (documents.isNotEmpty) ...[
            Text(
              'Documents',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.description),
                    label: Text('Document ${index + 1}'),
                    onPressed: () async {
                      final url = documents[index];
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),
          ] else
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.description_outlined,
                        size: 48, color: Colors.grey[600]),
                    SizedBox(height: 12),
                    Text(
                      'No documents available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            icon: Icon(Icons.upload_file),
            label: Text('Upload More Documents'),
            onPressed: () => _uploadDocuments(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (formData.leadDetails?['documents'] is List<dynamic>)
            _buildDocumentPreview(
                (formData.leadDetails?['documents'] as List<dynamic>)
                    .map((e) => e as PlatformFile)
                    .toList()),
          SizedBox(height: 32),
          Container(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: _isSaving
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.save),
              label: Text(_isSaving ? 'Saving...' : 'Save Changes'),
              onPressed: _isSaving
                  ? null // Button is disabled while saving
                  : () async {
                      setState(() {
                        _isSaving = true;
                      });

                      try {
                        // Your existing save logic here
                        var data = formData.leadDetails;
                        List<String> photoUrls = [];
                        try {
                          photoUrls = await uploadFiles(
                              data['photos'] ?? [], '66a9e5990027b4011eb6');
                          List<String> existingphotoUrls =
                              widget.lead.toMap()['photoUrls'];
                          _editedData['photoUrls'] = [
                            ...existingphotoUrls,
                            ...photoUrls
                          ];
                        } catch (e) {
                          print('Error uploading photos: $e');
                        }

                        List<PlatformFile> documents =
                            ((data['documents'] as List<dynamic>?) ?? [])
                                .map((item) => item as PlatformFile)
                                .toList();

                        List<String> documentUrls = [];
                        List<String> existingdocumentUrls =
                            widget.lead.toMap()['documentUrls'];
                        try {
                          documentUrls = await uploadPlatformFiles(
                              documents, '66a9e5c90002d611a9db');
                          _editedData['documentUrls'] = [
                            ...existingdocumentUrls,
                            ...documentUrls
                          ];
                        } catch (e) {
                          print('Error uploading documents: $e');
                        }

                        String leadType = widget.lead
                            .toMap()['leadType']
                            .toString()
                            .split('.')
                            .last
                            .toLowerCase();
                        _editedData['leadType'] = leadType;

                        var data1 = await convertDataWithoutAsso2(
                            _editedData, leadType, _editedData['propertyTyp']);
                        await updatePropertyLead(
                            data1, widget.lead.toMap()['id']);

                        ref.read(projectRepositoryProvider);
                        ref.refresh(projectRepositoryProvider);
                        ref.read(selectedIndexProvider1.notifier).state = 0;

                        Navigator.pushNamed(context, '/dashboard');
                        Phoenix.rebirth(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12),
                                Text('Property lead updated successfully'),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(16),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.error, color: Colors.white),
                                SizedBox(width: 12),
                                Text('Error updating property lead'),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(16),
                          ),
                        );
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isSaving = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
