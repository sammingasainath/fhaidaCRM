import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:slider_button/slider_button.dart';
import 'dart:io';

final customBoQProvider = StateProvider<bool>((ref) => false);
final isOwnerDifferentProvider = StateProvider<bool>((ref) => false);
final selectedServicesProvider = StateProvider<List<String>>((ref) => []);
final priorityProvider = StateProvider<bool>((ref) => false);

class ProjectDetailsForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customBoQ = ref.watch(customBoQProvider);
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
        backgroundColor:
            Color.fromARGB(255, 255, 255, 255), // Use your purple theme color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Name Of Work'),
              SizedBox(height: 15),
              _buildTextField('Location'),
              SizedBox(height: 15),
              _buildSwitch('Is the Owner Different Person?', (value) {
                ref.read(isOwnerDifferentProvider.notifier).state = value;
              }, Color.fromARGB(255, 158, 15, 235),
                  initialValue: isOwnerDifferent),
              SizedBox(height: 15),
              if (isOwnerDifferent) ...[
                _buildTextField('Name of Owner'),
                SizedBox(height: 15),
                _buildTextField('Phone Number of Owner'),
              ],
              SizedBox(height: 15),
              _buildSwitch('Custom BoQ?', (value) {
                ref.read(customBoQProvider.notifier).state = value;
              }, Color.fromARGB(255, 158, 15, 235), initialValue: customBoQ),
              SizedBox(height: 15),
              if (customBoQ) ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 158, 15, 235), // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      await uploadFileToFirebase(file);
                    }
                  },
                  child: Text('Upload Custom BOQ'),
                ),
              ] else ...[
                _buildTextField('Number of bore holes'),
                SizedBox(height: 15),
                _buildTextField('Depth per bore hole in metres'),
                SizedBox(height: 15),
                _buildMultiSelect(
                    'Services Required',
                    [
                      'Soil Testing',
                      'Rock Drilling',
                      'Exclude Report',
                    ],
                    selectedServices, (services) {
                  ref.read(selectedServicesProvider.notifier).state = services;
                }),
                SizedBox(height: 15),
                _buildTextField('Area in SFT'),
              ],
              SizedBox(height: 15),
              _buildCheckbox('Priority', (value) {
                ref.read(priorityProvider.notifier).state = value!;
              }, initialValue: priority),
              SizedBox(height: 20),
              _buildTextField('Additional Remarks'),
              SizedBox(height: 20),
              Center(
                child: SliderButton(
                  action: () {
                    return Future.value(true);
                    // Handle form submission
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
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildSwitch(
      String label, void Function(bool) onChanged, Color activeColor,
      {required bool initialValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Switch(
          value: initialValue,
          onChanged: onChanged,
          activeColor: activeColor,
          activeTrackColor: Color.fromARGB(255, 208, 171, 229),
          trackOutlineColor: MyColor(),
        ),
      ],
    );
  }

  Widget _buildMultiSelect(String label, List<String> options,
      List<String> selectedOptions, Function(List<String>) onSelectionChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 10.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: selectedOptions.contains(option),
              onSelected: (bool selected) {
                final newSelectedOptions = List<String>.from(selectedOptions);
                if (selected) {
                  newSelectedOptions.add(option);
                } else {
                  newSelectedOptions.remove(option);
                }
                onSelectionChanged(newSelectedOptions);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, void Function(bool?)? onChanged,
      {required bool initialValue}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Checkbox(
          value: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> uploadFileToFirebase(File file) async {
    try {
      await FirebaseStorage.instance
          .ref('boq/${file.path.split('/').last}')
          .putFile(file);
    } catch (e) {
      // Handle errors
    }
  }
}

class MyColor extends WidgetStateColor {
  const MyColor() : super(23);
  @override
  Color resolve(Set<WidgetState> states) {
    return const Color.fromARGB(255, 208, 171, 229);
  }
}

void main() {
  runApp(ProviderScope(child: MaterialApp(home: ProjectDetailsForm())));
}
