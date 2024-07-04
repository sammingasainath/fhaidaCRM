import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:slider_button/slider_button.dart';
import 'dart:io';
import '../providers/custom_boq_provider.dart';
import '../providers/is_owner_different_provider.dart';
import '../providers/priority_provider.dart';
import '../providers/selected_services_provider.dart';
import '../services/project_form_upload_details.dart';
import '../widgets/checkbox.dart';
import '../widgets/multi_select_options.dart';
import '../widgets/switch.dart';
import '../widgets/text_field.dart';
import '../widgets/circular_progress_indicator_widget.dart';

final projectNameController = TextEditingController();
final projectLocationController = TextEditingController();
final ownerNameController = TextEditingController();
final ownerPhoneController = TextEditingController();
final boreHolesController = TextEditingController();
final boreHoleDepthController = TextEditingController();
final areaController = TextEditingController();
final remarksController = TextEditingController();

class ProjectDetailsForm extends ConsumerStatefulWidget {
  @override
  _ProjectDetailsFormState createState() => _ProjectDetailsFormState();
}

class _ProjectDetailsFormState extends ConsumerState<ProjectDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String? customBoqUrl;
  String? selectedFileName;

  @override
  Widget build(BuildContext context) {
    final customBoQ = ref.watch(customBoqProvider);
    final isOwnerDifferent = ref.watch(isOwnerDifferentProvider);
    final selectedServices = ref.watch(selectedServicesProvider);
    final priority = ref.watch(priorityProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Color.fromARGB(255, 158, 15, 235)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Name Of Work',
                  controller: projectNameController,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  label: 'Location',
                  controller: projectLocationController,
                ),
                SizedBox(height: 15),
                CustomSwitch(
                  label: 'Is the Owner Different Person?',
                  onChanged: (value) {
                    ref.read(isOwnerDifferentProvider.notifier).state = value;
                  },
                  activeColor: Color.fromARGB(255, 158, 15, 235),
                  initialValue: isOwnerDifferent,
                ),
                SizedBox(height: 15),
                if (isOwnerDifferent) ...[
                  CustomTextField(
                    label: 'Name of Owner',
                    controller: ownerNameController,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    label: 'Phone Number of Owner',
                    controller: ownerPhoneController,
                  ),
                ],
                SizedBox(height: 15),
                CustomSwitch(
                  label: 'Custom BoQ?',
                  onChanged: (value) {
                    ref.read(customBoqProvider.notifier).state = value;
                  },
                  activeColor: Color.fromARGB(255, 158, 15, 235),
                  initialValue: customBoQ,
                ),
                SizedBox(height: 15),
                if (customBoQ) ...[
                  if (selectedFileName == null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 158, 15, 235),
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          customBoqUrl = await uploadFileToFirebase(file);
                          setState(() {
                            selectedFileName = result.files.single.name;
                          });
                        }
                      },
                      child: Text('Upload Custom BOQ'),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.file_present),
                          SizedBox(width: 10),
                          Text(selectedFileName!),
                        ],
                      ),
                    ),
                ] else ...[
                  CustomTextField(
                    label: 'Number of bore holes',
                    controller: boreHolesController,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    label: 'Depth per bore hole in metres',
                    controller: boreHoleDepthController,
                  ),
                  SizedBox(height: 15),
                  CustomMultiSelect(
                    label: 'Services Required',
                    options: [
                      'Soil Testing',
                      'Rock Drilling',
                      'Exclude Report'
                    ],
                    selectedOptions: selectedServices,
                    onSelectionChanged: (services) {
                      ref.read(selectedServicesProvider.notifier).state =
                          services;
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    label: 'Area in SFT',
                    controller: areaController,
                  ),
                ],
                SizedBox(height: 15),
                CustomCheckbox(
                  label: 'Priority',
                  onChanged: (value) {
                    ref.read(priorityProvider.notifier).state = value!;
                  },
                  initialValue: priority,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: 'Additional Remarks',
                  controller: remarksController,
                ),
                SizedBox(height: 20),
                Center(
                  child: SliderButton(
                    action: () async {
                      if (_formKey.currentState!.validate()) {
                        await saveProjectDetailsToFirestore(
                            name: projectNameController.text,
                            location: projectLocationController.text,
                            isOwnerDifferent: isOwnerDifferent,
                            ownerName: ownerNameController.text,
                            ownerPhone: ownerPhoneController.text,
                            customBoQ: customBoQ,
                            customBoqUrl: customBoqUrl,
                            context: context,
                            ref: ref);
                        return Future.value(true);
                      }
                      return Future.value(false);
                    },
                    label: const Text(
                      'Slide to Submit',
                      style: TextStyle(
                        color: Color.fromARGB(255, 158, 15, 235),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    icon: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 158, 15, 235),
                      ),
                    ),
                    boxShadow: BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                    width: 300,
                    height: 60,
                    radius: 30,
                    buttonColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 158, 15, 235),
                    highlightedColor: Colors.white,
                    baseColor: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
