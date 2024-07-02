import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';

class AddDrugWidget extends StatefulWidget {
  const AddDrugWidget({super.key});

  @override
  State<AddDrugWidget> createState() => _AddDrugWidgetState();
}

class _AddDrugWidgetState extends State<AddDrugWidget> {
  
    List<String> drugTypes = [
    'CAPSULE',
    'CREAM',
    'DROPS',
    'FOAM',
    'GEL',
    'INHALER',
    'INJECTION',
    'LOTION',
    'MOUTHWASH',
    'OINTMENT',
    'POWDER',
    'SHAMPOO',
    'SPRAY',
    'SYRINGE',
    'SYRUP',
    'TABLET',
    'TOOTHPASTE',
    'CUSTOM',
    'GARGLE',
    'SOLUTION',
    'LOZENGES',
    'DT',
    'BUCCAL PASTE',
    'DRY SYRUP',
    'DISPERSIBLE TABLET (DT)',
  ];
  
  
  List<String> drugDosages = [
    'mg',
    'mcg',
    'gm',
    'ml',
    'IU',
    'units',
    'million spores',
    'mg SR',
    '%',
    '% w/v',
    '% w/w',
    'NA',
  ];
  
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Drug'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                 
                 const SizedBox(height: 10),
                  XCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          
                          
                          XInput(
                            color: Colors.grey.shade200, 
                            label: 'Name',
                            hintText: 'Enter name',
                          ),
                          
                          XSelect(
                            color: Colors.grey.shade200, 
                          label: 'Type',
                          options: drugTypes.map((e) =>
                            DropDownItem(
                             label: e,
                             value: e,)
                           ).toList(),
                          onChanged: (value){}),
                          
                          XInput(
                            color: Colors.grey.shade200, 
                            label: 'Strength',
                            hintText: 'Enter strength',
                          ),
                          
                          XSelect(
                            color: Colors.grey.shade200, 
                          label: 'Dosage',
                          options: drugDosages.map((e) =>
                            DropDownItem(
                             label: e,
                             value: e,)
                           ).toList(),
                          onChanged: (value){}),
                          
                          XInput(
                            color: Colors.grey.shade200, 
                            height: 0.1,
                            label: 'Note',
                            hintText: 'Enter note',
                          ),
                          
                          
                          XButton(
                            label: 'Save',
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}