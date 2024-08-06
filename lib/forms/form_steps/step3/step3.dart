import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models.dart';
import '../../property_form.dart';
import 'FlatForm.dart';
import 'HouseForm.dart';
import 'CommercialBuildingsForm.dart';
import 'PlotForm.dart';
import 'SellRentForm.dart';

class Step3Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(LeadFormProvider);
    final formNotifier = ref.read(LeadFormProvider.notifier);

    if (formData.action == LeadAction.purchaseFrom ||
        formData.action == LeadAction.toLet) {
      if (formData.propertyTypes!.contains(PropertyType.flat)) {
        return FlatForm(formData: formData, formNotifier: formNotifier);
      } else if (formData.propertyTypes!.contains(PropertyType.house)) {
        return HouseForm(formData: formData, formNotifier: formNotifier);
      } else if (formData.propertyTypes!
          .contains(PropertyType.commercialBuilding)) {
        return CommercialBuildingForm(
            formData: formData, formNotifier: formNotifier);
      } else if (formData.propertyTypes!
              .contains(PropertyType.residentialPlots) ||
          formData.propertyTypes!.contains(PropertyType.commercialPlots)) {
        return PlotForm(formData: formData, formNotifier: formNotifier);
      }
    } else {
      return SellRentForm(formData: formData, formNotifier: formNotifier);
    }

    return Center(child: Text('Please select a property type in Step 2'));
  }
}

class CustomStepperForm extends StatefulWidget {
  final List<Widget> steps;
  final String title;

  CustomStepperForm({required this.steps, required this.title});

  @override
  _CustomStepperFormState createState() => _CustomStepperFormState();
}

class _CustomStepperFormState extends State<CustomStepperForm> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          for (int i = 0; i < widget.steps.length; i++)
            ExpansionTile(
              title: Text('Step ${i + 1}'),
              initiallyExpanded: i == _currentStep,
              onExpansionChanged: (expanded) {
                if (expanded) {
                  setState(() {
                    _currentStep = i;
                  });
                }
              },
              children: [widget.steps[i]],
            ),
        ],
      ),
    );
  }
}
