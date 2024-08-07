import 'package:anucivil_client/appwrite/services/convert_data_buy&rent.dart';
import 'package:anucivil_client/appwrite/services/convert_data_sell&tolet.dart';
import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:anucivil_client/providers/project_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

import 'models.dart';
import 'form_steps/step1.dart';
import './form_steps/step2.dart';
import 'form_steps/step3/step3.dart';
import './form_steps/step4.dart';
import './form_steps/step5.dart';
import 'package:dart_appwrite/dart_appwrite.dart';

class PropertyFormScreen extends ConsumerStatefulWidget {
  @override
  _PropertyFormScreenState createState() => _PropertyFormScreenState();
}

class _PropertyFormScreenState extends ConsumerState<PropertyFormScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(5, (_) => GlobalKey<FormState>());
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(LeadFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lead Form'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentStep + 1) / 5,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: _currentStep,
                    onStepContinue: () {
                      if (_formKeys[_currentStep].currentState!.validate()) {
                        if (_currentStep < 4) {
                          setState(() {
                            _currentStep++;
                          });
                        } else {
                          _submitForm();
                        }
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep > 0) {
                        setState(() {
                          _currentStep--;
                        });
                      }
                    },
                    steps: [
                      _buildStep('', Step1Form(), 0),
                      _buildStep('', Step2Form(), 1),
                      _buildStep('', Step3Form(), 2),
                      _buildStep('', Step4Form(), 3),
                      _buildStep('', Step5Form(), 4),
                    ],
                  ),
                ),
              ],
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Step _buildStep(String title, Widget content, int step) {
    return Step(
      title: Text(title),
      content: Form(
        key: _formKeys[step],
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: content,
          ),
        ),
      ),
      isActive: _currentStep >= step,
    );
  }

  void _submitForm() async {
    // Implement form submission logic here
    // You can use Appwrite to save the form data

    String sellRentProperties = '';
    List<String> sellRentPropertiesList = [];
    var formData = ref.read(LeadFormProvider);
    print(formData.leadDetails);
    var data = formData.leadDetails;

    if (formData.action == LeadAction.purchaseFrom ||
        formData.action == LeadAction.toLet) {
      try {
        var data1;

        if (formData.action == LeadAction.purchaseFrom) {
          for (var item in formData.propertyTypes) {
            switch (item) {
              case PropertyType.flat:
                sellRentProperties = 'flat';
                break;
              case PropertyType.house:
                sellRentProperties = 'house';
                break;
              case PropertyType.residentialPlots:
                sellRentProperties = 'plots';
                break;
              case PropertyType.commercialBuilding:
                sellRentProperties = 'commercialBuilding';
                break;
              case PropertyType.commercialPlots:
                sellRentProperties = 'commercialPlots';
                break;
              default:
                print('Unknown weather condition.');
                break;
            }
          }

          data1 = await convertData(data, 'sell', sellRentProperties);
        }

        if (formData.action == LeadAction.toLet) {
          for (var item in formData.propertyTypes) {
            switch (item) {
              case PropertyType.flat:
                sellRentProperties = 'flat';
                break;
              case PropertyType.house:
                sellRentProperties = 'house';
                break;
              case PropertyType.residentialPlots:
                sellRentProperties = 'plots';
                break;
              case PropertyType.commercialBuilding:
                sellRentProperties = 'commercialBuilding';
                break;
              case PropertyType.commercialPlots:
                sellRentProperties = 'commercialPlots';
                break;
              default:
                print('Unknown weather condition.');
                break;
            }
          }
          data1 = await convertData(data, 'tolet', sellRentProperties);
        }

        await createPropertyLead(data1);
        print('Form submitted');
        ref.refresh(projectRepositoryProvider);
        ref.read(selectedIndexProvider1.notifier).state = 0;
      } catch (e) {
        print('Error creating Property Lead: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Handle sellTo and rentTo actions
    }
  }
}
