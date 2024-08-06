import 'dart:io'; // Add this import for using File
import 'package:anucivil_client/forms/maps_functionality/place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../models.dart';
import '../property_form.dart';

class Step4Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(LeadFormProvider);
    final formNotifier = ref.read(LeadFormProvider.notifier);

    if (formData.action == LeadAction.purchaseFrom) {
      return PurchaseFromStep4Form(
          formData: formData, formNotifier: formNotifier);
    } else if (formData.action == LeadAction.toLet) {
      return PurchaseFromStep4Form(
          formData: formData, formNotifier: formNotifier);
    } else {
      return Center(child: Text('No additional fields for this action'));
    }
  }
}

class PurchaseFromStep4Form extends ConsumerWidget {
  final LeadFormData formData;
  final LeadFormNotifier formNotifier;

  PurchaseFromStep4Form({required this.formData, required this.formNotifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deadlineToSell = formData.leadDetails!['deadlineToSell'] as String?;
    final deadlineDate =
        deadlineToSell != null ? DateTime.tryParse(deadlineToSell) : null;

    String formattedDate = deadlineDate != null
        ? "${deadlineDate.toLocal().toString().split(' ')[0]}"
        : '';

    return SingleChildScrollView(
      child: Column(
        children: [
          CheckboxListTile(
            title: Text('Also Want to Buy?'),
            value: formData.leadDetails!['alsoWantToBuy'] as bool? ?? false,
            onChanged: (bool? value) {
              formNotifier.updateLeadDetails({'alsoWantToBuy': value});
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Rough Address'),
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'roughAddress': value}),
          ),
          SizedBox(height: 16),
          PlaceSearchField(
            label: 'Customer Visit Location',
            uniqueKey: 'customerVisitLocation',
            onSelected: (result) {
              formNotifier.updateLeadDetails({
                'customerVisitLocation': result.description,
                'customerVisitLat': result.lat,
                'customerVisitLng': result.lng,
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Exact Address'),
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'exactAddress': value}),
          ),
          SizedBox(height: 16),
          PlaceSearchField(
            label: 'Exact Visit Location',
            uniqueKey: 'exactVisitLocation',
            onSelected: (result) {
              formNotifier.updateLeadDetails({
                'exactVisitLocation': result.description,
                'exactVisitLat': result.lat,
                'exactVisitLng': result.lng,
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Video Link (YouTube)'),
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'videoLink': value}),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description of Property'),
            maxLines: 3,
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'description': value}),
          ),
          SizedBox(height: 16),
          Text('Photos', style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => _uploadPhotos(context),
            child: Text('Upload Photos'),
          ),
          if (formData.leadDetails?['photos'] is List<String>)
            _buildPhotoPreview(
                formData.leadDetails?['photos'] as List<String> ?? []),
          SizedBox(height: 16),
          Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => _uploadDocuments(context),
            child: Text('Upload Documents'),
          ),
          if (formData.leadDetails?['documents'] is List<dynamic>)
            _buildDocumentPreview(
                (formData.leadDetails?['documents'] as List<dynamic>)
                    .map((e) => e as PlatformFile)
                    .toList()),
          if (formData.action == LeadAction.purchaseFrom)
            TextFormField(
              decoration: InputDecoration(labelText: 'Property Cost Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier
                  .updateLeadDetails({'costPrice': double.tryParse(value)}),
            ),
          if (formData.action == LeadAction.purchaseFrom)
            TextFormField(
              decoration: InputDecoration(labelText: 'Property Selling Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier
                  .updateLeadDetails({'sellingPrice': double.tryParse(value)}),
            ),
          if (formData.action == LeadAction.purchaseFrom)
            TextFormField(
              decoration: InputDecoration(labelText: 'Commission Percentage'),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier.updateLeadDetails(
                  {'commissionPercentage': double.tryParse(value)}),
            ),
          if (formData.action == LeadAction.purchaseFrom)
            TextFormField(
              decoration: InputDecoration(labelText: 'Deadline to Sell'),
              controller: TextEditingController(text: formattedDate),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: deadlineDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) {
                  formNotifier.updateLeadDetails(
                      {'deadlineToSell': pickedDate.toIso8601String()});
                }
              },
            ),
          if (formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Property Rent'),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier
                  .updateLeadDetails({'propertyRent': double.tryParse(value)}),
            ),
          if (formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Preferred Tenant'),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  formNotifier.updateLeadDetails({'preferredTenant': value}),
            ),
          if (formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Preferred Advance'),
              keyboardType: TextInputType.number,
              onChanged: (value) => formNotifier.updateLeadDetails(
                  {'preferredAdvance': double.tryParse(value)}),
            ),
        ],
      ),
    );
  }

  Future<void> _uploadPhotos(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      final existingPhotos =
          formData.leadDetails?['photos'] as List<String>? ?? <String>[];
      final newPhotos = images.map((e) => e.path).toList();

      if (existingPhotos.length + newPhotos.length > 5) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You can upload a maximum of 5 photos.'),
        ));
        return;
      }

      formNotifier.updateLeadDetails({
        'photos': [...existingPhotos, ...newPhotos],
      });
    }
  }

  Future<void> _uploadDocuments(BuildContext context) async {
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

  Widget _buildPhotoPreview(List<String> photoPaths) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photoPaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Image.file(
                  File(photoPaths[index]),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      final updatedPhotos = List<String>.from(photoPaths);
                      updatedPhotos.removeAt(index);
                      formNotifier.updateLeadDetails({
                        'photos': updatedPhotos,
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
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
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: documentFiles.length,
        itemBuilder: (context, index) {
          final file = documentFiles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement document viewing logic here
                  },
                  child: Text(file.name),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      formNotifier.updateLeadDetails({
                        'documents': List<PlatformFile>.from(documentFiles)
                          ..removeAt(index),
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
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
}
